local globals = {}

-- content area width
globals.w = display.contentWidth
-- content area height
globals.h = display.contentHeight

-- x in percent of content width
globals.percentX = function(percent)
	return globals.w/100 * percent
end

-- y in percent of content height
globals.percentY = function(percent)
	return globals.h/100 * percent
end

-- display width
globals.displayW = (display.contentWidth - display.screenOriginX*2)
-- display height
globals.displayH = (display.contentHeight - display.screenOriginY*2)

-- x in percent of display width
globals.displayPercentX = function(percent)
	return globals.displayW/100 * percent
end

-- y in percent of display height
globals.displayPercentY = function(percent)
	return globals.displayH/100 * percent
end

-- center of content area
globals.centerX = display.contentCenterX
globals.centerY = display.contentCenterY

-- content corners
globals.left = 0
globals.right = display.contentWidth
globals.top = 0
globals.bottom = display.contentHeight

-- display corners
globals.displayRight = display.contentWidth - display.screenOriginX
globals.displayLeft = display.screenOriginX
globals.displayTop = display.screenOriginY 
globals.displayBottom = display.contentHeight - display.screenOriginY 

-- display corners
globals.magicW = globals.w * 1.1875
globals.magicH = globals.h * 1.125


globals.scaleX = 1/display.contentScaleX
globals.scaleY = 1/display.contentScaleY

globals.unusedWidth = globals.displayW - globals.w
globals.unusedHeight = globals.displayH - globals.h

globals.deviceWidth = math.floor((globals.displayW/display.contentScaleX) + 0.5)
globals.deviceHeight = math.floor((globals.displayH/display.contentScaleY) + 0.5)


globals.luaVersion = _G._VERSION
globals.onSimulator = system.getInfo( "environment" ) == "simulator"
globals.platformVersion = system.getInfo( "platformVersion" )

return globals