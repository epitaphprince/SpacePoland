local game = game

local gameChaptersConfig =
{
    {
        id = 1,
        name = "Первая глава",
        background = R.game_chapter1_gameBackground,
        line = R.game_chapter1_line,
        lineCircle = R.game_chapter1_lineCircle,
        angle = R.game_chapter1_angle,
        angleCircle = R.game_chapter1_angleCircle,
        triangle = R.game_chapter1_triangle,
        triangle90 = R.game_chapter1_triangle90,
        triangleCircle = R.game_chapter1_triangleCircle,
        triangleCircle90 = R.game_chapter1_triangleCircle90,
        tetra = R.game_chapter1_tetra,
        point = R.game_chapter1_point,
        multipoint = R.game_chapter1_multipoint,
        lowLive = R.game_lowLive,
        middleLive = R.game_middleLive,
        fullLive = R.game_fullLive,
        pauseButton = R.game_pauseButton,
        controller = R.game_chapter1_controller,
        playerIdle = R.game_chapter1_playerIdle,
        playerActive = R.game_chapter1_playerActive,
        playerAngry = R.game_chapter1_playerActive,
        playerWound = R.game_chapter1_playerWound,
        russianEnemyIdle = R.game_chapter1_russianEnemyIdle,
        russianEnemyActive = R.game_chapter1_russianEnemyActive,
        russianEnemyAngry = R.game_chapter1_russianEnemyAngry,
        russianEnemyFear = R.game_chapter1_russianEnemyFear,
        russianEnemyWound = R.game_chapter1_russianEnemyWound,
        germanEnemyIdle = R.game_chapter1_germanEnemyIdle,
        germanEnemyActive = R.game_chapter1_germanEnemyActive,
        germanEnemyAngry = R.game_chapter1_germanEnemyAngry,
        germanEnemyFear = R.game_chapter1_germanEnemyFear,
        germanEnemyWound = R.game_chapter1_germanEnemyWound,
        ufoEnemyIdle = R.game_chapter1_ufoEnemyIdle,
        ufoEnemyActive = R.game_chapter1_ufoEnemyActive,
        ufoEnemyAngry = R.game_chapter1_ufoEnemyAngry,
        ufoEnemyFear = R.game_chapter1_ufoEnemyFear,
        ufoEnemyWound = R.game_chapter1_ufoEnemyWound,
    },
    {
        id = 2,
        name = "Вторая глава",
        background = R.game_chapter2_gameBackground,
        line = R.game_chapter2_line,
        lineCircle = R.game_chapter2_lineCircle,
        angle = R.game_chapter2_angle,
        angleCircle = R.game_chapter2_angleCircle,
        triangle = R.game_chapter2_triangle,
        triangle90 = R.game_chapter2_triangle90,
        triangleCircle = R.game_chapter2_triangleCircle,
        triangleCircle90 = R.game_chapter2_triangleCircle90,
        tetra = R.game_chapter2_tetra,
        point = R.game_chapter2_point,
        multipoint = R.game_chapter2_multipoint,
        lowLive = R.game_lowLive,
        middleLive = R.game_middleLive,
        fullLive = R.game_fullLive,
        pauseButton = R.game_pauseButton,
        controller = R.game_chapter2_controller
    },
    {
        id = 3,
        name = "Третья глава",
        background = R.game_chapter3_gameBackground,
        line = R.game_chapter3_line,
        lineCircle = R.game_chapter3_lineCircle,
        angle = R.game_chapter3_angle,
        angleCircle = R.game_chapter3_angleCircle,
        triangle = R.game_chapter3_triangle,
        triangle90 = R.game_chapter3_triangle90,
        triangleCircle = R.game_chapter3_triangleCircle,
        triangleCircle90 = R.game_chapter3_triangleCircle90,
        tetra = R.game_chapter3_tetra,
        point = R.game_chapter3_point,
        multipoint = R.game_chapter3_multipoint,
        lowLive = R.game_lowLive,
        middleLive = R.game_middleLive,
        fullLive = R.game_fullLive,
        pauseButton = R.game_pauseButton,
        controller = R.game_chapter3_controller
    }
}

game.chapterConfig = gameChaptersConfig[GlobalOptions.currentChapter]

game:addEventListener("onGameEvent", gameChaptersConfig)
function gameChaptersConfig:onGameEvent(event)
    local phase = event.phase

    if(phase == "changeScene") then
        game:removeEventListener("onGameEvent", self)
        self = nil
        package.loaded[R.game_gameChaptersConfigScript] = nil
    end
end

return gameChaptersConfig
