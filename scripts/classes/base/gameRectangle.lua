local game = game
local gameRectangle = Class()
local index = 0
local levelData = game.levelData

function gameRectangle:initialize(config)
    self.config = config or {}
    local config = self.config
    local size = config.size
    local offset = GlobalOptions.gameElementOffset

    local rect = display.newRect(config.x + offset, config.y + offset, size, size)
    rect.isVisible = false
    self.rect = rect
    index = index + 1
    self.index = index
    self.type = config.type
    self.display = config.display or game

    self.display:insert(rect)

    game:addEventListener("onGameEvent", self)
    self:resumeRectangle()
end

function gameRectangle:collate(event)
    local x = event.x
    local y = event.y
    if((x > self.rect.contentBounds.xMin and x < self.rect.contentBounds.xMax)
        and (y > self.rect.contentBounds.yMin and y < self.rect.contentBounds.yMax)) then
        return true
    else
        return false
    end
end

function gameRectangle:pauseRectangle()
    game:removeEventListener(GlobalOptions.movePlayerEvent, self)
    if(self.type == GlobalOptions.line or
        self.type == GlobalOptions.lineCircle or
        self.type == GlobalOptions.angle or
        self.type == GlobalOptions.angleCircle or
        self.type == GlobalOptions.triangle or
        self.type == GlobalOptions.triangleCircle or
        self.type == GlobalOptions.tetra) then
            game:removeEventListener(GlobalOptions.moveEnemyEvent, self)
        end
end

function gameRectangle:resumeRectangle()
    game:addEventListener(GlobalOptions.movePlayerEvent, self)
    if(self.type == GlobalOptions.line or
        self.type == GlobalOptions.lineCircle or
        self.type == GlobalOptions.angle or
        self.type == GlobalOptions.angleCircle or
        self.type == GlobalOptions.triangle or
        self.type == GlobalOptions.triangleCircle or
        self.type == GlobalOptions.tetra) then
            game:addEventListener(GlobalOptions.moveEnemyEvent, self)
        end
end

function gameRectangle:movePlayer(event)
    local player = event.target
    local direction = player.direction
    local blockSize = GlobalOptions.gameElementSize

    local xOffset = 0
    local yOffset = 0
    if(direction == GlobalOptions.directions.up) then
        yOffset = - blockSize
    end
    if(direction == GlobalOptions.directions.down) then
        yOffset = blockSize
    end
    if(direction == GlobalOptions.directions.left) then
        xOffset = - blockSize
    end
    if(direction == GlobalOptions.directions.right) then
        xOffset = blockSize
    end

    local x = player.image.x + xOffset
    local y = player.image.y + yOffset

    local collate = self:collate({x = x, y = y})

    if(collate) then
        if(self.type == GlobalOptions.line or
            self.type == GlobalOptions.lineCircle or
            self.type == GlobalOptions.angle or
            self.type == GlobalOptions.angleCircle or
            self.type == GlobalOptions.triangle or
            self.type == GlobalOptions.triangleCircle or
            self.type == GlobalOptions.tetra) then
            player:stopPlayer()
        end
        if(self.type == GlobalOptions.point) then
            game:dispatchEvent({name = GlobalOptions.getPointEvent, target = self})
            self:remove()
        end
        if(self.type == GlobalOptions.multipoint and not player.multipointActivation) then
            game:dispatchEvent({name = GlobalOptions.getMultipointEvent, target = self})
            self:remove()
        end
    end

end

function gameRectangle:moveEnemy(event)
    local enemy = event.target
    local direction = enemy.direction
    local blockSize = GlobalOptions.gameElementSize

    local xOffset = 0
    local yOffset = 0
    if(direction == GlobalOptions.directions.up) then
        yOffset = - blockSize
    end
    if(direction == GlobalOptions.directions.down) then
        yOffset = blockSize
    end
    if(direction == GlobalOptions.directions.left) then
        xOffset = - blockSize
    end
    if(direction == GlobalOptions.directions.right) then
        xOffset = blockSize
    end

    local x = enemy.image.x + xOffset
    local y = enemy.image.y + yOffset

    local collate = self:collate({x = x, y = y})

    if(collate) then
        enemy:getNextDirection({state = GlobalOptions.enemyState.normal})
    end
end

function gameRectangle:remove()
    game:removeEventListener("onGameEvent", self)
    game:removeEventListener(GlobalOptions.movePlayerEvent, self)
    game:removeEventListener(GlobalOptions.moveEnemyEvent, self)
    self.rect:removeSelf()
    self:dispose()
    package.loaded[R.base_gameRectangleScript] = nil
end

function gameRectangle:onGameEvent(event)
    local phase = event.phase
    if(phase == "changeScene" or phase == "hideOverlay") then
        self:remove()
    end
    if(phase == "resume") then
    end
    if(phase == "pause") then
    end
end

function gameRectangle:create(config)

    local type = config.type
        local angle = config.angle
        local size = config.size
        local x = config.x
        local y = config.y
        local size = GlobalOptions.gameElementSize
        local display = config.display or game

        if(type == GlobalOptions.line or
            type == GlobalOptions.lineCircle or
            type == GlobalOptions.point or
            type == GlobalOptions.multipoint) then
            gameRectangle:new({x = x, y = y, type = type, size = size, display = display})
        end
        if(type == GlobalOptions.angle or type == GlobalOptions.angleCircle) then
            if(angle == 0) then
                gameRectangle:new({x = x, y = y, type = type, size = size, display = display})
                gameRectangle:new({x = x, y = y + size, type = type, size = size, display = display})
                gameRectangle:new({x = x + size, y = y, type = type, size = size, display = display})
            end
            if(angle == 90) then
                gameRectangle:new({x = x, y = y, type = type, size = size, display = display})
                gameRectangle:new({x = x + size, y = y, type = type, size = size, display = display})
                gameRectangle:new({x = x + size, y = y + size, type = type, size = size, display = display})
            end
            if(angle == 180) then
                gameRectangle:new({x = x, y = y + size, type = type, size = size, display = display})
                gameRectangle:new({x = x + size, y = y, type = type, size = size, display = display})
                gameRectangle:new({x = x + size, y = y + size, type = type, size = size, display = display})
            end
            if(angle == 270) then
                gameRectangle:new({x = x, y = y, type = type, size = size, display = display})
                gameRectangle:new({x = x, y = y + size, type = type, size = size, display = display})
                gameRectangle:new({x = x + size, y = y + size, type = type, size = size,  display = display})
            end
        end
        if(type == GlobalOptions.triangle or type == GlobalOptions.triangleCircle) then
            if(angle == 0) then
                gameRectangle:new({x = x, y = y, type = type, size = size, display = display})
                gameRectangle:new({x = x, y = y + size, type = type, size = size, display = display})
                gameRectangle:new({x = x, y = y + 2 * size, type = type, size = size, display = display})
                gameRectangle:new({x = x + size, y = y + size, type = type, size = size, display = display})
            end
            if(angle == 90) then
                gameRectangle:new({x = x, y = y, type = type, size = size, display = display})
                gameRectangle:new({x = x + size, y = y, type = type, size = size, display = display})
                gameRectangle:new({x = x + size, y = y + size, type = type, size = size, display = display})
                gameRectangle:new({x = x + 2 * size, y = y, type = type, size = size, display = display})
            end
            if(angle == 180) then
                gameRectangle:new({x = x, y = y + size, type = type, size = size, display = display})
                gameRectangle:new({x = x + size, y = y, type = type, size = size, display = display})
                gameRectangle:new({x = x + size, y = y + size, type = type, size = size, display = display})
                gameRectangle:new({x = x + size, y = y + 2 * size, type = type, size = size, display = display})
            end
            if(angle == 270) then
                gameRectangle:new({x = x, y = y + size, type = type, size = size, display = display})
                gameRectangle:new({x = x + size, y = y, type = type, size = size, display = display})
                gameRectangle:new({x = x + size, y = y + size, type = type, size = size, display = display})
                gameRectangle:new({x = x + 2 * size, y = y + size, type = type, size = size, display = display})
            end
        end
        if(type == GlobalOptions.tetra) then
            gameRectangle:new({x = x, y = y + size, type = type, size = size, display = display})
            gameRectangle:new({x = x + size, y = y, type = type, size = size, display = display})
            gameRectangle:new({x = x + size, y = y + size, type = type, size = size, display = display})
            gameRectangle:new({x = x + size, y = y + 2 * size, type = type, size = size, display = display})
            gameRectangle:new({x = x + 2 * size, y = y + size, type = type, size = size, display = display})
        end
end

for i = 1, #levelData do
    gameRectangle:create(levelData[i])
end

return gameRectangle
