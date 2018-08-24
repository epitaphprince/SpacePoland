R = require("scripts.lib.GResources")

require(R.preLoadScript)
require(R.globalOptionsScript)

local composer = require("composer")

composer.gotoScene(R.levelsListScene)
