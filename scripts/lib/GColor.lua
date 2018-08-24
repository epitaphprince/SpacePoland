local GColor = {}

function GColor:new( colors )
	self = {}

	for name, hex in pairs( colors ) do
		self[  name  ] = GColor:fromHex(hex, true)
	end

	return self
end

function GColor:fromHex( hex, asTable )
	local color = {}
	color[ 1 ] = tonumber( string.sub( hex, 1, 2 ), 16 ) or 1
	color[ 2 ] = tonumber( string.sub( hex, 3, 4 ), 16 ) or 1
	color[ 3 ] = tonumber( string.sub( hex, 5, 6 ), 16 ) or 1
	color[ 4 ] = tonumber( string.sub( hex, 7, 8 ), 16 )
	
	for i = 1, #color, 1 do
		color[ i ] = color[ i ] / 255
	end
	if asTable then
		return color
	else
		return unpack(color)
	end
end

function GColor:hex( hex )
	return GColor:fromHex(hex)
end

return GColor