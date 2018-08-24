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
    game.sceneName = "pause"

    require(R.game_pauseMenuScript)
end


-- show()
function scene:show( event )
    game = self.view
    game.sceneName = "pause"
    local phase = event.phase
    local parent = event.parent

    if ( phase == "will" ) then
        parent:pauseGame()
    elseif ( phase == "did" ) then
        require(R.game_pauseMenuScript)
    end
end

-- hide()
function scene:hide( event )
    scene = self.view
    local phase = event.phase
    local parent = event.parent

    if ( phase == "will" ) then
        scene:dispatchEvent({name = "onGameEvent", phase = "hideOverlay"})
        parent:resumeGame()
    elseif ( phase == "did" ) then
    end
end

-- destroy()
function scene:destroy( event )

   local sceneGroup = self.view
   -- Code here runs prior to the removal of scene's view

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
