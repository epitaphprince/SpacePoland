local game = game
local gameHud = {}

require(R.game_pauseButtonScript)
require(R.game_controllerScript)
require(R.game_liveLevelScript)
local bonusesObject = require(R.game_bonusScript)
require(R.game_pointsCounterScript)

game:addEventListener(GlobalOptions.bonusActivationEvent, gameHud)
game:addEventListener(GlobalOptions.selectBonusesEvent, gameHud)

local bonusesConfig =
{
    -- Increase player speed
    {
        id = 1,
        defaultImage = R.game_bonus1,
        type = GlobalOptions.bonusTypes.increasePlayerSpeed
    },
    -- Player immortal
    {
        id = 2,
        defaultImage = R.game_bonus2,
        type = GlobalOptions.bonusTypes.playerImmortal
    },
    -- Decrease enemies speed
    {
        id = 3,
        defaultImage = R.game_bonus3,
        type = GlobalOptions.bonusTypes.decreaseEnemiesSpeed
    },
    -- Double coins
    {
        id = 4,
        defaultImage = R.game_bonus4,
        type = GlobalOptions.bonusTypes.doubleCoins
    },
    -- Stole live
    {
        id = 5,
        defaultImage = R.game_bonus5,
        type = GlobalOptions.bonusTypes.stoleLive
    }
}

function gameHud:bonusActivation(event)
    local state = event.state
    if(state == GlobalOptions.bonusState.activation) then
        GlobalOptions.variables.activeBonus = true
    else
        GlobalOptions.variables.activeBonus = false
    end
end

function gameHud:selectBonuses(event)
    local selectedBonuses = event.bonuses
    for k,v in pairs( selectedBonuses ) do
        local config = bonusesConfig[v]
        config.x = G.percentX(5) * k * 1.5
        config.y = G.percentY(75)
        config.width = G.percentX(7)
        config.height = G.percentX(7)
        bonusesObject:new(config)
    end
end

game:addEventListener("onGameEvent", gameHud)
function gameHud:onGameEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        game:removeEventListener("onGameEvent", self)
        game:removeEventListener(GlobalOptions.bonusActivationEvent, self)
        game:removeEventListener(GlobalOptions.selectBonusesEvent, self)
        self = nil
        package.loaded[R.game_gameHudScript] = nil
    end
end

return gameHud
