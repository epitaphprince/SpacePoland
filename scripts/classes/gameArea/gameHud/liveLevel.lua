local game = game
local Base = require(R.base_gameControlScript)
local liveLevel = Class(Base)

function liveLevel:initialize(config)
    Base.initialize(self, config)

    self.lives = config.lives
    self.fullLiveImage = display.newImage(self.image, config.fullLive)
    self.fullLiveImage.x = G.percentX(9)
    self.middleLiveImage = display.newImage(self.image, config.middleLive)
    self.middleLiveImage.x = G.percentX(9)
    self.middleLiveImage.isVisible = false
    self.lowLiveImage = display.newImage(self.image, config.lowLive)
    self.lowLiveImage.x = G.percentX(9)
    self.lowLiveImage.isVisible = false

    self.image.activeImage = display.newImageRect(self.image, config.activeImage, config.width, config.height)
    self.image.angryImage = display.newImageRect(self.image, config.angryImage, config.width, config.height)
    self.image.fearImage = display.newImageRect(self.image, config.fearImage, config.width, config.height)
    self.image.woundImage = display.newImageRect(self.image, config.woundImage, config.width, config.height)
    self.image.activeImage.isVisible = false
    self.image.angryImage.isVisible = false
    self.image.fearImage.isVisible = false
    self.image.woundImage.isVisible = false

    game:addEventListener("onGameEvent", self)
    game:addEventListener("changeState", self)
    game:addEventListener(GlobalOptions.decreaseLivePointsEvent, self)
    game:addEventListener(GlobalOptions.increaseLivePointsEvent, self)
end

function liveLevel:onGameEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        game:removeEventListener("onGameEvent", self)
        game:removeEventListener("changeState", self)
        game:removeEventListener(GlobalOptions.decreaseLivePointsEvent, self)
        game:removeEventListener(GlobalOptions.increaseLivePoints, self)
        GlobalOptions.playerLives = 3
        self.image:removeSelf()
        package.loaded[R.game_liveLevelScript] = nil
    end
end

function liveLevel:changeState(event)
    local id = event.id
    local state = event.state
    if(self.id == id) then
        self.image.defaultImage.isVisible = false
        self.image.activeImage.isVisible = false
        self.image.angryImage.isVisible = false
        self.image.fearImage.isVisible = false
        self.image.woundImage.isVisible = false
        if(state == "normal" or state == "immortal") then
            self.image.activeImage.isVisible = true
        end
        if(state == "attack") then
            self.image.angryImage.isVisible = true
        end
        if(state == "fear") then
            self.image.fearImage.isVisible = true
        end
        if(state == "wound") then
            self.image.woundImage.isVisible = true
        end
    end
end

function liveLevel:decreaseLivePoints(event)
    local id = event.id
    if(self.id == id) then
        self.lives = self.lives - 1
        if(self.id == GlobalOptions.player) then
            GlobalOptions.playerLives = self.lives
        end

        if(self.lives == 2) then
            self.fullLiveImage.isVisible = false
            self.middleLiveImage.isVisible = true
        end
        if(self.lives == 1) then
            self.middleLiveImage.isVisible = false
            self.lowLiveImage.isVisible = true
        end
        if(self.lives == 0) then
            self.lowLiveImage.isVisible = false
            self:checkGameOver()
        end
    end
end

function liveLevel:increaseLivePoints(event)
    local id = event.id
    if(self.id == id) then
        self.lives = self.lives + 1

        if(self.lives == 3) then
            self.middleLiveImage.isVisible = false;
            self.fullLiveImage.isVisible = true
        end
        if(self.lives == 2) then
            self.fullLiveImage.isVisible = false
            self.middleLiveImage.isVisible = true
        end
    end
end

function liveLevel:checkGameOver()
    if(self.id == GlobalOptions.player and self.lives == 0) then
        game:dispatchEvent({name = GlobalOptions.gameOverEvent})
    end
end

local liveLevelsConfig =
{
    -- player
    {
        id = GlobalOptions.player,
        lives = 3,
        x = G.percentX(11),
        y = G.percentY(83),
        width = G.percentX(10),
        height = G.percentX(10),
        defaultImage = game.chapterConfig.playerIdle,
        activeImage = game.chapterConfig.playerActive,
        angryImage = game.chapterConfig.playerAngry,
        fearImage = game.chapterConfig.playerAngry,
        woundImage = game.chapterConfig.playerWound,
        lowLive = game.chapterConfig.lowLive,
        middleLive = game.chapterConfig.middleLive,
        fullLive = game.chapterConfig.fullLive
    },
    -- russian enemy
    {
        id = GlobalOptions.russianEnemy,
        lives = 3,
        x = G.percentX(11),
        y = G.percentY(92),
        width = G.percentX(10),
        height = G.percentX(10),
        defaultImage = game.chapterConfig.russianEnemyIdle,
        activeImage = game.chapterConfig.russianEnemyActive,
        angryImage = game.chapterConfig.russianEnemyAngry,
        fearImage = game.chapterConfig.russianEnemyFear,
        woundImage = game.chapterConfig.russianEnemyWound,
        lowLive = game.chapterConfig.lowLive,
        middleLive = game.chapterConfig.middleLive,
        fullLive = game.chapterConfig.fullLive
    },
    -- german enemy
    {
        id = GlobalOptions.germanEnemy,
        lives = 3,
        x = G.percentX(81),
        y = G.percentY(83),
        width = G.percentX(10),
        height = G.percentX(10),
        defaultImage = game.chapterConfig.germanEnemyIdle,
        activeImage = game.chapterConfig.germanEnemyActive,
        angryImage = game.chapterConfig.germanEnemyAngry,
        fearImage = game.chapterConfig.germanEnemyFear,
        woundImage = game.chapterConfig.germanEnemyWound,
        lowLive = game.chapterConfig.lowLive,
        middleLive = game.chapterConfig.middleLive,
        fullLive = game.chapterConfig.fullLive
    },
    -- ufo enemy
    {
        id = GlobalOptions.ufoEnemy,
        lives = 3,
        x = G.percentX(81),
        y = G.percentY(92),
        width = G.percentX(10),
        height = G.percentX(10),
        defaultImage = game.chapterConfig.ufoEnemyIdle,
        activeImage = game.chapterConfig.ufoEnemyActive,
        angryImage = game.chapterConfig.ufoEnemyAngry,
        fearImage = game.chapterConfig.ufoEnemyFear,
        woundImage = game.chapterConfig.ufoEnemyWound,
        lowLive = game.chapterConfig.lowLive,
        middleLive = game.chapterConfig.middleLive,
        fullLive = game.chapterConfig.fullLive
    }
}

for i = 1, #liveLevelsConfig do
    liveLevel:new(liveLevelsConfig[i])
end

return liveLevel
