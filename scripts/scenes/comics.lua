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
    menu = self.view
    menu.sceneName = "comics"

    if(event.params) then
        menu.selectedComics = event.params.selectedComics
    end
    require(R.menu_comicsMenuScript)
end


-- show()
function scene:show( event )
    menu = self.view
    menu.sceneName = "comics"
    local phase = event.phase

    if(event.params) then
        menu.selectedComics = event.params.selectedComics
    end

    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
        require(R.menu_comicsMenuScript)
    end
end

-- hide()
function scene:hide( event )
    menu = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        menu:dispatchEvent({name = "onMenuEvent", phase = "changeScene"})
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
