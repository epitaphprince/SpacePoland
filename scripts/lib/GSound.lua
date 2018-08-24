
local GSound = {}
local GSound_mt = { __index = GSound }

GSound.enabled = true
GSound.volume = true

--- Initiates a new GSound object.
-- @param channels A table containing what channels have been reserved for this sound library.
-- @return The new object.
function GSound:new( channels )
    local self = {}
    setmetatable( self, GSound_mt )
    	
    self.sounds = {}
    
    self.channels = channels
    
    return self
    
end

--- Adds a sound file to this sound library.
-- @param pathOrHandle The path to the sound file or a pre-loaded sound handle.
-- @param name The name of the sound.
-- @param baseDirectory The base directory of the sound. Optional, defaults to system.ResourceDirectory.
-- @param lazyLoading If true then the sound will only be loaded when it is first played. Optional, defaults to false.
function GSound:add( pathOrHandle, name, baseDirectory, lazyLoading )

	self.sounds = self.sounds or {}

	self.sounds[ name ] = {}

	if type( pathOrHandle ) == "string" then
		if lazyLoading then
			self.sounds[ name ].baseDirectory = baseDirectory or system.ResourceDirectory 
		else
			pathOrHandle = audio.loadSound( pathOrHandle, baseDirectory or system.ResourceDirectory )
		end
	end
	
	self.sounds[ name ].handle = pathOrHandle

end

-- Removes a sound from the library and destroys it.
-- @param name The name of the sound.
function GSound:remove( name )

	if not self.sounds or not self.sounds[ name ] then
		return
	end
	
	if self.sounds[ name ].channel then
		audio.stop( self.sounds[ name ].channel )
	end
	
	if self.sounds[ name ].handle then
		audio.dispose( self.sounds[ name ].handle )
	end
	
	self.sounds[ name ] = nil
	
end

--- Plays a pre-added sound file.
-- @param name The name of the sound.
-- @param options The options for the sound, optional.
function GSound:play( name, options )

	if not self.sounds or not self.sounds[ name ] then
		print("WARNING: Sound \"" .. name .. "\" not found")
		return
	end

	if type( self.sounds[ name ].handle ) == "string" then
		self.sounds[ name ].handle = audio.loadSound( self.sounds[ name ].handle, self.sounds[ name ].baseDirectory )
	end

	if not self.enabled then
		return
	end
	
	local options = options or {}
	
	options.channel = self:findFreeChannel()
	
	if options.channel then
		audio.setVolume( self.volume, { channel = options.channel } )
		self.sounds[ name ].channel = audio.play( self.sounds[ name ].handle, options )
	end
	
end

--- Gets sound object.
-- @param name The name of the sound.
-- @param options The options for the sound, optional.
-- @return The sound object.

function GSound:get( name, options )
	return {
		name = name,
		play = function()
			self:play(name, options)
		end,
		remove = function()
			self:remove(name)
		end

	}
end

--- Sets the volume of the sound library.
-- @param volume The new volume.
function GSound:setVolume( volume )
	
	self.volume = volume
	
	if self.volume > 1 then
		self.volume = 1
	elseif self.volume < 0 then
		self.volume = 0
	end
	
	for i = 1, #self.channels, 1 do
		audio.setVolume( self.volume, { channel = self.channels[ i ] } )
	end
	
end

--- Gets the volume of the sound library.
-- @return The volume.
function GSound:getVolume()
	return self.volume
end

--- Finds a free channel.
-- @return The channel number. Nil if none found.
function GSound:findFreeChannel()

	if self.channels then
		for i = 1, #self.channels, 1 do
			if not audio.isChannelActive( self.channels[ i ] ) then
				return self.channels[ i ]
			end
		end
	else
		return audio.findFreeChannel()
	end
	
end

--- Removes all loaded sounds and destroys them.
function GSound:removeAll()

	self:stopAll()
	
	for k, v in pairs( self.sounds ) do
		if v then
			audio.dispose( v.handle )
		end
		v.handle = nil
	end
	self.sounds = {}
	
end

--- Stops all currently active sounds.
function GSound:stopAll()
	if self.channels then
		for i = 1, #self.channels, 1 do
			audio.stop( self.channels[ i ] )
		end
	end
end

--- Destroys this GSound object.
function GSound:destroy()

	self:stopAll()
	self:removeAll()

	self.sounds = nil
	
end

return GSound
