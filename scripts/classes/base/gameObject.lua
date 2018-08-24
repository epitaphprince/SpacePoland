local game = game
local gameObject = Class()
local composer = require("composer")

local directions =
{
    up = "up",
    down = "down",
    left = "left",
    right = "right",
    none = "none"
}

function gameObject:move(options)
    if(not gameObject.pauseState) then
        local direction = options.direction
        local speed = options.speed
        local xDirection, yDirection

        if(direction == directions.up) then
            xDirection = 0
            yDirection = -speed
        end
        if(direction == directions.down) then
            xDirection = 0
            yDirection = speed
        end
        if(direction == directions.left) then
            xDirection = -speed
            yDirection = 0
        end
        if(direction == directions.right) then
            xDirection = speed
            yDirection = 0
        end

        if(direction ~= directions.none) then
            self.image:translate(xDirection, yDirection)
        end
    end
end

function gameObject:collate(event)
    local x = event.x
    local y = event.y
    if((x > self.image.contentBounds.xMin and x < self.image.contentBounds.xMax)
        and (y > self.image.contentBounds.yMin and y < self.image.contentBounds.yMax)) then
        return true
    else
        return false
    end
end

function gameObject:pauseObject()
    self.pauseState = true
end

function gameObject:resumeObject()
    self.pauseState = false
end

function gameObject:checkWin()
    if(GlobalOptions.objectsToWin <= 0) then
        game:dispatchEvent({name = GlobalOptions.gameWinEvent})
    end
end

function gameObject:checkAttack()
    if(GlobalOptions.levelPoints >= GlobalOptions.pointsToRussianAttack and GlobalOptions.attacks.russian == false) then
        GlobalOptions.attacks.russian = true
        game:dispatchEvent({name = "changeState", id = GlobalOptions.russianEnemy, state = "attack"})
    end
    if(GlobalOptions.levelPoints >= GlobalOptions.pointsToGermanAttack and GlobalOptions.attacks.german == false) then
        GlobalOptions.attacks.german = true
        game:dispatchEvent({name = "changeState", id = GlobalOptions.germanEnemy, state = "attack"})
    end
    if(GlobalOptions.levelPoints >= GlobalOptions.pointsToUfoAttack and GlobalOptions.attacks.ufo == false) then
        GlobalOptions.attacks.ufo = true
        game:dispatchEvent({name = "changeState", id = GlobalOptions.ufoEnemy, state = "attack"})
    end
end

function gameObject:align()

    local blockSize = GlobalOptions.gameElementSize

    self.image.x = (self.image.x / blockSize) * blockSize
    self.image.y = (self.image.y / blockSize) * blockSize
end

function gameObject:checkCoordinates(object)
    if(self.image.x == object.rect.x and self.image.y == object.rect.y) then
        return true
    end
    return false
end

function gameObject:initialize(config)
    self.config = config or {}
    local config = self.config
    self.config.size = GlobalOptions.gameElementSize
    self.image = display.newGroup()
    self.display = config.display or game
    self.pauseState = false

    local type = config.type
    self.type = type
    local chapterConfig = game.chapterConfig
    if(type == GlobalOptions.line) then
        config.defaultImage = chapterConfig.line
    end
    if(type == GlobalOptions.lineCircle) then
        config.defaultImage = chapterConfig.lineCircle
    end
    if(type == GlobalOptions.angle) then
        config.defaultImage = chapterConfig.angle
    end
    if(type == GlobalOptions.angleCircle) then
        config.defaultImage = chapterConfig.angleCircle
    end
    if(type == GlobalOptions.triangle) then
        if(config.angle == 90 or config.angle == 270) then
            config.defaultImage = chapterConfig.triangle90
        else
            config.defaultImage = chapterConfig.triangle
        end
    end
    if(type == GlobalOptions.triangleCircle) then
        if(config.angle == 90 or config.angle == 270) then
            config.defaultImage = chapterConfig.triangleCircle90
        else
            config.defaultImage = chapterConfig.triangleCircle
        end
    end
    if(type == GlobalOptions.tetra) then
        config.defaultImage = chapterConfig.tetra
    end
    if(type == GlobalOptions.point) then
        config.defaultImage = chapterConfig.point
    end
    if(type == GlobalOptions.multipoint) then
        config.defaultImage = chapterConfig.multipoint
    end
    if(type == GlobalOptions.player) then
        config.defaultImage = chapterConfig.playerIdle
        config.activeImage = chapterConfig.playerActive
        config.angryImage = chapterConfig.playerAngry
        config.woundImage = chapterConfig.playerWound
    end
    if(type == GlobalOptions.russianEnemy) then
        config.defaultImage = chapterConfig.russianEnemyIdle
        config.activeImage = chapterConfig.russianEnemyActive
        config.fearImage = chapterConfig.russianEnemyFear
        config.angryImage = chapterConfig.russianEnemyAngry
        config.woundImage = chapterConfig.russianEnemyWound
    end
    if(type == GlobalOptions.germanEnemy) then
        config.defaultImage = chapterConfig.germanEnemyIdle
        config.activeImage = chapterConfig.germanEnemyActive
        config.fearImage = chapterConfig.germanEnemyFear
        config.angryImage = chapterConfig.germanEnemyAngry
        config.woundImage = chapterConfig.germanEnemyWound
    end
    if(type == GlobalOptions.ufoEnemy) then
        config.defaultImage = chapterConfig.ufoEnemyWound
        config.activeImage = chapterConfig.ufoEnemyActive
        config.fearImage = chapterConfig.ufoEnemyFear
        config.angryImage = chapterConfig.ufoEnemyAngry
        config.woundImage = chapterConfig.ufoEnemyWound
    end

    self:createImage(config)

    self.display:insert(self.image)

    game:addEventListener("onGameEvent", gameObject)

    self:resumeObject()
end

function gameObject:createImage(config)
    local type = config.type
    local angle = config.angle
    local sizeW = config.size
    local sizeH = config.size
    local x = config.x
    local y = config.y

    if(type == GlobalOptions.point) then
        sizeW = 0.75 * config.size
        sizeH = 0.75 * config.size
    end

    if(type == GlobalOptions.line or
        type == GlobalOptions.lineCircle or
        type == GlobalOptions.multipoint or
        type == GlobalOptions.germanEnemy or
        type == GlobalOptions.russianEnemy or
        type == GlobalOptions.ufoEnemy or
        type == GlobalOptions.player) then

    end
    if(type == GlobalOptions.angle or
        type == GlobalOptions.angleCircle) then
        sizeW = 2 * config.size
        sizeH = 2 * config.size
    end
    if(type == GlobalOptions.triangle or
        type == GlobalOptions.triangleCircle) then
        if(angle == 90 or angle == 270) then
            sizeW = 3 * config.size
            sizeH = 2 * config.size
        end
        if(angle == 0 or angle == 180) then
            sizeW = 2 * config.size
            sizeH = 3 * config.size
        end
        if(angle == 270) then
            angle = 180
        end
        if(angle == 90) then
            angle = 0
        end
    end
    if(type == GlobalOptions.tetra) then
        sizeW = 3 * config.size
        sizeH = 3 * config.size
    end

    local defaultImage = display.newImageRect(self.image, config.defaultImage, sizeW, sizeH)
    self.image.defaultImage = defaultImage
    if(defaultImage.width > config.size and defaultImage.height > config.size) then
        self.image.x = x + defaultImage.width * 0.5
        self.image.y = y + defaultImage.height * 0.5
    else
        self.image.x = x + config.size * 0.5
        self.image.y = y + config.size * 0.5
    end

    defaultImage.rotation = angle
end

function gameObject:onGameEvent(event)
    local phase = event.phase
    if(phase == "pause") then
        self:pauseObject()
    end
    if(phase == "resume") then
        self:resumeObject()
    end
    if(phase == "changeScene" or phase == "hideOverlay") then
        game:removeEventListener("onGameEvent", self)

        gameObject:dispose()
        package.loaded[R.base_gameObjectScript] = nil
    end
end

return gameObject
