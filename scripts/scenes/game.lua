local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
    game = self.view
    game.sceneName = "game"

    if(event.params) then
        game.selectedLevel = event.params.selectedLevel
    end

    require(R.game_gameAreaScript)

    game:dispatchEvent({name = "onGameEvent", phase = "game", chapter = GlobalOptions.currentChapter})
end


-- show()
function scene:show( event )
    game = self.view
    game.sceneName = "game"
    local phase = event.phase

    if(event.params) then
        game.selectedLevel = event.params.selectedLevel
    end

    if ( phase == "will" ) then
       -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        require(R.game_gameAreaScript)
    end
end

-- hide()
function scene:hide( event )
    game = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        game:dispatchEvent({name = "onGameEvent", phase = "changeScene"})
        GlobalOptions.objectsToWin = 0
    elseif ( phase == "did" ) then
    end
end

-- destroy()
function scene:destroy( event )

   local sceneGroup = self.view
   -- Code here runs prior to the removal of scene's view

end

function scene:bonusesSelect(bonuses)
    game = self.view
    game:dispatchEvent({name = GlobalOptions.selectBonusesEvent, bonuses = bonuses})
end

function scene:pauseGame()
    game = self.view
    game.sceneName = "game"
    if(GlobalOptions.pause) then
        game:dispatchEvent({name = "onGameEvent", phase = "pause"})
    end
end

function scene:resumeGame()
    game = self.view
    game.sceneName = "game"
    if(not GlobalOptions.pause and GlobalOptions.gameStart) then
        game:dispatchEvent({name = "onGameEvent", phase = "resume"})
    end
    if(not GlobalOptions.gameStart) then
        game:dispatchEvent({name = "onGameEvent", phase = "start"})
        GlobalOptions.gameStart = true
    end
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
