--
--		GMusic allows you to play a list of background music tracks in linear or random 
--		order in your Corona SDK powered apps.
--
----------------------------------------------------------------------------------------------------

local GMusic = {}

local GMusic_mt = { __index = GMusic }

local channel = audio.findFreeChannel()
audio.reserveChannels(1)

GMusic.enabled = true

GMusic.volume = 1

--- Initiates a new GMusicG object.
-- @return The new object, number of reserved channel.
function GMusic:new()
    local self = {}
    setmetatable( self, GMusic_mt )

    self.tracks = {}
    
    self.currentIndex = nil
    self.currentTrack = nil
    
    self.random = false
    self.loop = true
    self.playback = false

    self.firstPlay = true
      
    return self, channel
end

--- Adds a track to the music library.
-- @param pathOrHandle Either the path to the music file or the already loaded sound/stream handle.
-- @param name The name of the track, used for easy access. Optional.
-- @return The index for the newly added track as well as the name if provided ( in case it was created dynamically ).
-- @param baseDirectory The base directory of the music file. Optional, defaults to system.ResourceDirectory.
function GMusic:add( pathOrHandle, name, baseDirectory )
	
	self.tracks[ #self.tracks + 1 ] = 
	{ 
		path = pathOrHandle,
		handle = pathOrHandle,
		baseDirectory = baseDirectory or system.ResourceDirectory,
		name = name 
	}

	if #self.tracks == 1 then
		self.currentTrack = self.tracks[ 1 ]
		self.currentIndex = 1
	end
	
	if self.random then
		self.currentTrack = self.tracks[ math.random( 1, #self.tracks ) ]
	end

	return #self.tracks, name
	
end

function GMusic:setEnabled( value )
	self.enabled = value

	if value then
		self:resume()
	else
		self:pause()
	end
end

--- Sets the volume of the music library.
-- @param volume The new volume.
function GMusic:setVolume( volume )
	self.volume = volume
	
	audio.setVolume( self.volume, { channel = channel } )
end

--- Gets the volume of the music library.
-- @return The volume.
function GMusic:getVolume()
	return self.volume
end

--- Starts playing the current track. If one is already playing it will be stopped immediately.
-- @param name The name of the track to play. Optional.
-- @param options Options for the track. Optional. If there is an onComplete function and it returns true, the next track won't play.
function GMusic:play( name, options )
	
	options = options or {}

	local onComplete = options.onComplete
	
	local onTrackComplete = function( event )
	
		local handled = false
		
		if onComplete then
			handled = onComplete( event )
		end
		
		if not handled and event.completed then
			self:next()
		end
		
	end
	
	local track = self.currentTrack
	
	if name then
            for i = 1, #self.tracks, 1 do
                if self.tracks[ i ].name == name then
                        track = self.tracks[ i ]
                        self.currentIndex = i
                        break
                end
            end	
	end
	
	if track then
		audio.setVolume( self.volume, { channel = channel } )

		if not track.handle or type( track.handle ) == "string" then
			track.handle = audio.loadStream( track.path, track.baseDirectory )
		end
		
		options.channel = channel
		options.onComplete = onTrackComplete

		audio.stop( channel )
                songTitle.text = track.name
                
		-- TODO: crossfade
		audio.play( track.handle, options )
                self.playback = true
		self.firstPlay = false

		if not self.enabled then
                    self:pause()
		end
		
	end
	
end

--- Pauses the currently playing track.
-- @param channel The channel number.
function GMusic:pause()
	audio.pause( channel )
        self.playback = false
end

--- Resume the currently playing track.
-- @param channel The channel number.
function GMusic:resume()
	audio.resume( channel )
        self.playback = true
end

--- Fades out the volume of the currently playing track. When complete the track will be stopped and the volume reset.
-- @param time The duration of the fadeout. Optional, defaults to 500.
-- @param onComplete Function to be called when the fade is complete. Optional.
-- @param channel The channel number. Optional, defaults to all of them.
function GMusic:fadeOut( time, onComplete )

	time = time or 500

	-- channel = channel or channel

	local t
	
	local onComplete = function()
		if t then timer.cancel( t ) end
		t = nil
		self:stop( channel )
		self:setVolume( self.volume )
		if onComplete then onComplete() end
	end

	audio.fadeOut{ channel = channel, time = time }
	
	t = timer.performWithDelay( time, onComplete, 1 )
end

--- Stops the current track and jumps to the next one. The next track will be random if .random is set to true.
-- @param onComplete Function to be called when the track is complete. Optional. If the onComplete function returns true, the next track won't play.
function GMusic:next( onComplete )
	
	local previousIndex = self.currentIndex
	local nextIndex = self.currentIndex
	
	if self.random then
		if #self.tracks > 1 then
			while nextIndex == self.currentIndex do
				nextIndex = math.random( 1, #self.tracks )
			end
		else
			nextIndex = 1
		end
	else
		nextIndex = self.currentIndex + 1
	end
	
	if previousIndex == nextIndex then
		nextIndex = nextIndex + 1
	end
	
	if nextIndex > #self.tracks then
		if self.random or self.loop then
			nextIndex = 1
		else
			return
		end
	end
	
	self.currentIndex = nextIndex
	
	self.currentTrack = self.tracks[ self.currentIndex ]
	
	self:play( nil, { onComplete = onComplete } )
	
end

function GMusic:prev( onComplete )
	
	local previousIndex = self.currentIndex
	local nextIndex = self.currentIndex
	
	if self.random then
		if #self.tracks > 1 then
			while nextIndex == self.currentIndex do
				nextIndex = math.random( 1, #self.tracks )
			end
		else
			nextIndex = 1
		end
	else
		nextIndex = self.currentIndex - 1
	end
	
	if previousIndex == nextIndex then
		nextIndex = nextIndex - 1
	end
	
	if nextIndex < 1 then
		if self.random or self.loop then
			nextIndex = #self.tracks
		else
			return
		end
	end
	
	self.currentIndex = nextIndex
	
	self.currentTrack = self.tracks[ self.currentIndex ]
	
	self:play( nil, { onComplete = onComplete } )
	
end

--- Stops the currently playing track and rewinds it back to beginning.
function GMusic:stop()
	audio.rewind( { channel = channel } )
	
	audio.stop( channel )
        self.playback = false
end


--- Destroys this GMusic object.
function GMusic:destroy()

	self:stop( channel )
	
	for i = 1, #self.tracks, 1 do
		if self.tracks[ i ].handle then
			audio.dispose( self.tracks[ i ].handle )
		end
		self.tracks[ i ].handle = nil
		self.tracks[ i ] = nil
	end
	
	self.tracks = nil
	self = nil
	
end

return GMusic
