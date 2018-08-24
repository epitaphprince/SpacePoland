local game = game
local Base = require(R.base_gameControlScript)
local bonusSelectItem = Class(Base)
local selectedBonuses = 0
local bonusesSelectMenu = game.bonusesSelectMenu
game.selectedBonuses = {}

function bonusSelectItem:initialize(config)
    Base.initialize(self, config)

    self.id = config.id
    self.current = false
    local logo = display.newImageRect(self.image, config.logo, G.percentX(15), G.percentX(15))

    game:addEventListener("onGameEvent", self)
    game:addEventListener("selectBonusItem", self)
    self.image:addEventListener("touch", self)
end

function bonusSelectItem:touch(event)
    local phase = event.phase
    if(phase == "ended") then
        if(selectedBonuses < GlobalOptions.maxBonuses and selectedBonuses >= 0
            or (selectedBonuses == GlobalOptions.maxBonuses and self.current)) then
            self.current = not self.current
            if(self.current) then
                selectedBonuses = selectedBonuses + 1
                table.insert(game.selectedBonuses, self.id)
            else
                selectedBonuses = selectedBonuses - 1
                table.remove( game.selectedBonuses, table.indexOf( game.selectedBonuses, self.id ))
            end
            Base.push(self)
            game:dispatchEvent({name = "selectBonusItem", item = self})
        end
    end
end

function bonusSelectItem:selectBonusItem()
    if(not self.current and selectedBonuses == GlobalOptions.maxBonuses) then
        Base.disable(self)
    else
        Base.enable(self)
    end
end

function bonusSelectItem:onGameEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        game:removeEventListener("onMenuEvent", self)
        game:removeEventListener("selectBonusItem", self)
        self.image:removeEventListener("touch", self)
        self.text:removeSelf()
        self.image:removeSelf()
        package.loaded[R.game_bonusSelectItemScript] = nil
    end
end

local bonusItemsConfig =
{
    {
        id = 1,
        display = bonusesSelectMenu,
        logo = R.game_bonusSelect1,
        defaultImage = R.game_bonusSelectBack,
        alterImage = R.game_bonusSelectAlterBack,
        disabledImage = R.game_bonusSelectDisabledBack,
        width = G.percentX(20),
        height = G.percentX(20),
        x = G.centerX,
        y = G.percentY(10),
        value = settings.bonus1
    },
    {
        id = 2,
        display = bonusesSelectMenu,
        logo = R.game_bonusSelect2,
        defaultImage = R.game_bonusSelectBack,
        alterImage = R.game_bonusSelectAlterBack,
        disabledImage = R.game_bonusSelectDisabledBack,
        width = G.percentX(20),
        height = G.percentX(20),
        x = G.percentX(15),
        y = G.percentY(25),
        value = settings.bonus2,
    },
    {
        id = 3,
        display = bonusesSelectMenu,
        logo = R.game_bonusSelect3,
        defaultImage = R.game_bonusSelectBack,
        alterImage = R.game_bonusSelectAlterBack,
        disabledImage = R.game_bonusSelectDisabledBack,
        width = G.percentX(20),
        height = G.percentX(20),
        x = G.percentX(30),
        y = G.percentY(48),
        value = settings.bonus3,
    },
    {
        id = 4,
        display = bonusesSelectMenu,
        logo = R.game_bonusSelect4,
        defaultImage = R.game_bonusSelectBack,
        alterImage = R.game_bonusSelectAlterBack,
        disabledImage = R.game_bonusSelectDisabledBack,
        width = G.percentX(20),
        height = G.percentX(20),
        x = G.percentX(70),
        y = G.percentY(48),
        value = settings.bonus4,
    },
    {
        id = 5,
        display = bonusesSelectMenu,
        logo = R.game_bonusSelect5,
        defaultImage = R.game_bonusSelectBack,
        alterImage = R.game_bonusSelectAlterBack,
        disabledImage = R.game_bonusSelectDisabledBack,
        width = G.percentX(20),
        height = G.percentX(20),
        x = G.percentX(85),
        y = G.percentY(25),
        value = settings.bonus5,
    }
}

for i = 1, #bonusItemsConfig do
    bonusSelectItem:new(bonusItemsConfig[i])
end

return bonusSelectItem
