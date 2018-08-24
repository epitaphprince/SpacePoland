local menu = menu
local Base = require(R.base_menuControlScript)
local levelItem = Class(Base)
local composer = require("composer")

local baseX = G.percentX(19) - G.w * (GlobalOptions.selectedScreen - 1)
local baseY = G.percentY(17.5)
local levelX = baseX
local levelY = baseY

local allowChooseLevel = true

function levelItem:initialize(number)

    local config =
    {
        defaultImage = R.menu_levelItem,
        width = G.percentX(28),
        height = G.percentX(28),
        x = levelX,
        y = levelY,
    }
    Base.initialize(self, config)

    self.id = number

    local levelId = tostring(self.id)

    -- Level numbers
    if(levelId:len() == 1) then
        local levelNumber = display.newImageRect(self.image, R.menu_levelItemNumbers .. levelId .. ".png", G.percentX(10), G.percentX(10))
        levelNumber.y = - G.percentY(2.5)
    end

    if(levelId:len() == 2) then
        local levelNumber1 = display.newImageRect(self.image, R.menu_levelItemNumbers .. levelId:sub(1, 1) .. ".png", G.percentX(10), G.percentX(10))
        levelNumber1.x = - G.percentX(4)
        levelNumber1.y = - G.percentY(2.5)

        local levelNumber2 = display.newImageRect(self.image, R.menu_levelItemNumbers .. levelId:sub(2) .. ".png", G.percentX(10), G.percentX(10))
        levelNumber2.x = G.percentX(4)
        levelNumber2.y = - G.percentY(2.5)
    end

    -- Level lock
    local open = settings:get("level" .. levelId .. "Open")
    if(not open) then
        self.enabled = false
        local lock = display.newImageRect(self.image, R.menu_levelItemLock, G.percentX(20), G.percentX(20))
    else
        self.enabled = true
    end

    self.scroll = true

    -- Level stars
    local stars = settings:get("level" .. levelId .. "Point")
    local baseStarX = - (G.percentX(5) * (stars)) / 2
    for i = 0, stars - 1 do
        local star = display.newImageRect(self.image, R.menu_levelItemStar, G.percentX(4), G.percentX(4))
        star.x = baseStarX + G.percentX(7.5) * i
        star.y = G.percentY(4.2)
    end

    levelX = baseX + math.fmod(number, 3) * G.percentX(31)

    if(math.fmod(number, 3) == 0) then
        levelY = levelY + G.percentY(17)
    end
    if(math.fmod(number, GlobalOptions.levelsOnScreen) == 0) then
        levelY = baseY
        baseX = baseX + G.w
        levelX = baseX
    end

    menu:addEventListener("onMenuEvent", self)
    menu:addEventListener("changeLevelScreen", self)
    self.image:addEventListener("touch", self)
end

function levelItem:changeLevelScreen(event)
    transition.to(self.image, {time = event.delay, x = self.image.x - event.index * G.w})

    self.scroll = false
    self.timer = timer.performWithDelay(event.delay,
    function()
        self.scroll = true;
    end)
end

function levelItem:touch(event)
    local phase = event.phase
    if (phase == "moved") then
        local dx = event.x - event.xStart
        if(self.scroll) then
            if ( dx < -10 ) then
                if(GlobalOptions.selectedScreen < GlobalOptions.levelsScreenCount) then
                    local index = 1
                    GlobalOptions.selectedScreen = GlobalOptions.selectedScreen + index
                    menu:dispatchEvent({name = "changeLevelScreen", delay = GlobalOptions.levelScreenDelay, index = index})
                    allowChooseLevel = false
                end
            end
            if ( dx > 10 ) then
                if(GlobalOptions.selectedScreen > 1) then
                    local index = -1
                    GlobalOptions.selectedScreen = GlobalOptions.selectedScreen + index
                    menu:dispatchEvent({name = "changeLevelScreen", delay = GlobalOptions.levelScreenDelay, index = index})
                    allowChooseLevel = false
                end
            end
        end
    end
    if(phase == "ended") then
        if(self.enabled and allowChooseLevel) then
            local options =
            {
                params = {selectedLevel = self.id}
            }
            composer.gotoScene(R.gameScene, options)
        end
        allowChooseLevel = true
    end
end

function levelItem:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        menu:removeEventListener("changeLevelScreen", self)
        if(self.timer) then
            timer.cancel(self.timer)
        end
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.menu_levelItemScript] = nil
    end
end

for i = 1, GlobalOptions.levelsCount do
    levelItem:new(i)
end

return levelItem
