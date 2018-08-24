local menu = menu

local comicsConfig = 
{
    {
        id = 1,
        name = "Chapter 1",
        images = 
        {
            {
                image = R.menu_chapter1_comics1
            },
            {
                image = R.menu_chapter1_comics2
            },
            {
                image = R.menu_chapter1_comics3
            },
            {
                image = R.menu_chapter1_comics4
            },
            {
                image = R.menu_chapter1_comics5
            }
        } 
    },
    {
        id = 2,
        name = "Chapter 2",
        images = 
        {
            {
                image = R.menu_chapter2_comics1
            },
            {
                image = R.menu_chapter2_comics2
            }
        } 
    },
    {
        id = 3,
        name = "Chapter 3",
        images = 
        {
            {
                image = R.menu_chapter3_comics1
            }
        } 
    },
    {
        id = 4,
        name = "Final",
        images = 
        {
            {
                image = R.menu_final_comics1
            },
            {
                image = R.menu_final_comics2
            },
            {
                image = R.menu_final_comics3
            },
            {
                image = R.menu_final_comics4
            },
            {
                image = R.menu_final_comics5
            }
        } 
    }
}

menu.comicsConfig = comicsConfig[menu.selectedComics]
menu.comicsCount = #menu.comicsConfig.images

menu:addEventListener("onMenuEvent", comicsConfig)
function comicsConfig:onMenuEvent(event)
    local phase = event.phase
    
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        self = nil
        package.loaded[R.menu_comicsConfigScript] = nil
    end
end

return comicsConfig
