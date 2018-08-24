local menu = menu
local comicsSlider = {}

function comicsSlider:changeComicsScreen(event)
    self.currentComics = self.currentComics + event.index
    self.comicsImage:removeSelf()
    self.comicsImage = display.newImageRect(menu, self.comicsConfig.images[self.currentComics].image, G.w, G.h)
    self.comicsImage.anchorX = 0; self.comicsImage.anchorY = 0
    self.comicsImage:toBack()
end

function comicsSlider:initialize()
    self.currentComics = menu.selectedComicsScreen
    self.comicsConfig = menu.comicsConfig
    self.comicsCount = #self.comicsConfig.images

    self.comicsImage = display.newImageRect(menu, self.comicsConfig.images[self.currentComics].image, G.w, G.h)
    self.comicsImage.anchorX = 0; self.comicsImage.anchorY = 0
    
    menu:addEventListener("changeComicsScreen", self)
    menu:addEventListener("onMenuEvent", self)
end
  
function comicsSlider:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        menu:removeEventListener("changeComicsScreen", self)
        self.comicsImage:removeSelf()
        self = nil
        package.loaded[R.menu_comicsSliderScript] = nil
    end
end

comicsSlider:initialize()

return comicsSlider

