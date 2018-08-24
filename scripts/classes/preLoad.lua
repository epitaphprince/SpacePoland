display.setStatusBar( display.HiddenStatusBar )

require(R.helpersScript)
require(R.classScript)
G = require( R.globalScript)

GameFont = {style = native.systemFont, size = 30, descriptionSize = 25, color = {0, 0, 0, 1} }

-- Settings
GData = require( R.dataScript )
settings = GData:new("settings")
settings:enableIntegrityControl( crypto.sha512, "spacePoland" )
settings:verifyIntegrity()
settings:loadDefaults()
-- First start
if(settings.startup == false) then
    settings:set("soundsEnabled", true)
    settings:set("musicEnabled", true)
    settings:set("startup", true)
end
settings:save()
-- Settings

widget = require("widget")
