local menu = menu
local Base = require(R.base_menuControlScript)
local comicsButton = Class(Base)
local composer = require("composer")

local baseX = G.centerX - G.w * (GlobalOptions.selectedScreen - 1)

function comicsButton:initialize(config)
    Base.initialize(self, config)
    self.id = config.id

    -- Comics lock
    local open = settings:get("comics" .. self.id .. "Open")
    if(not open) then
        self.enabled = false
        self:push()
    else
        self.enabled = true
    end

    self.scroll = true

    menu:addEventListener("changeLevelScreen", self)
    menu:addEventListener("onMenuEvent", self)
    self.image:addEventListener("touch", self)
end

function comicsButton:changeLevelScreen(event)
    transition.to(self.image, {time = event.delay, x = self.image.x - event.index * G.w})

    self.scroll = false
    self.timer = timer.performWithDelay(event.delay,
    function()
        self.scroll = true;
    end)
end

function comicsButton:touch(event)
    local phase = event.phase
    if(phase == "ended") then
        if(self.enabled) then
            local options =
            {
                params = {selectedComics = self.id}
            }
            composer.gotoScene(R.comicsScene, options)
        end
    end
end

local comicsButtonsConfig =
{
    {
        id = 1,
        defaultImage = R.menu_comicsButton1,
        alterImage = R.menu_comicsButton1Locked,
        x = baseX,
        y = G.percentY(94),
        width = G.percentX(55),
        height = G.percentY(10)
    },
    {
        id = 2,
        defaultImage = R.menu_comicsButton2,
        alterImage = R.menu_comicsButton2Locked,
        x = baseX + G.w,
        y = G.percentY(94),
        width = G.percentX(55),
        height = G.percentY(10)
    },
    {
        id = 3,
        defaultImage = R.menu_comicsButton3,
        alterImage = R.menu_comicsButton3Locked,
        x = baseX + G.w * 2,
        y = G.percentY(94),
        width = G.percentX(55),
        height = G.percentY(10)
    }
}

function comicsButton:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        menu:removeEventListener("changeLevelScreen", self)
        if(self.timer) then
            timer.cancel(self.timer)
        end
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.menu_comicsButtonScript] = nil
    end
end

for i = 1, #comicsButtonsConfig do
    comicsButton:new(comicsButtonsConfig[i])
end

return comicsButton
