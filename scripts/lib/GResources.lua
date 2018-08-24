local resources = {}


---- System scripts
--resources.googlePlay = "scripts.classes.googlePlay"
--resources.admob = "scripts.classes.admob"
--
---- Music and Sound
--
---- Music
--local musicFolder = "assets/music/"
--
--resources.music1 = musicFolder .. "music1.mp3"
--resources.music1Title = "Все ж мы люди"
--resources.music2 = musicFolder .. "music2.mp3"
--resources.music2Title = "Имперский слоник"
--resources.music3 = musicFolder .. "music3.mp3"
--resources.music3Title = "Братишке от братишек"
--resources.music4 = musicFolder .. "music4.mp3"
--resources.music4Title = "На работу"
--resources.music5 = musicFolder .. "music5.mp3"
--resources.music5Title = "Пахомовский централ"
--resources.music6 = musicFolder .. "music6.mp3"
--resources.music6Title = "Поехали!"
--resources.music7 = musicFolder .. "music7.mp3"
--resources.music7Title = "Полковнику никто не пишет"
--resources.music8 = musicFolder .. "music8.mp3"
--resources.music8Title = "Полковник"
--resources.music9 = musicFolder .. "music9.mp3"
--resources.music9Title = "Полуслоновый хип хоп"
--resources.music10 = musicFolder .. "music10.mp3"
--resources.music10Title = "Слоновый канкан"
--resources.music11 = musicFolder .. "music11.mp3"
--resources.music11Title = "Слоновый шансон"
--resources.music12 = musicFolder .. "music12.mp3"
--resources.music12Title = "Metal Gear Solid"
--resources.music13 = musicFolder .. "music13.mp3"
--resources.music13Title = "Зеленый слоник"
--resources.music14 = musicFolder .. "music14.mp3"
--resources.music14Title = "Still Alive"
--resources.music15 = musicFolder .. "music15.mp3"
--resources.music15Title = "Yesterday"
--
---- Sounds
--local soundFolder = "assets/sounds/"
--
---- common
--resources.tapSound = soundFolder .. "tap."
--resources.gamewinSound = soundFolder .. "gamewin.mp3"
--resources.gameoverSound = soundFolder .. "gameover.mp3"
--
---- hero
--resources.heroGetPointSound = soundFolder .. "pahom/getPoint.mp3"
--resources.heroGetBonusSound = soundFolder .. "pahom/getBonus.mp3"
--resources.heroPortBonusSound = soundFolder .. "pahom/portBonus.wav"
--resources.heroEpauletteBonusSound = soundFolder .. "pahom/epauletteBonus.mp3"
--resources.heroForkBonusSound = soundFolder .. "pahom/forkBonus.mp3"
--resources.heroCigaretteBonusSound = soundFolder .. "pahom/cigaretteBonus.mp3"
--resources.heroCheckersBonusSound = soundFolder .. "pahom/checkersBonus.mp3"
--resources.heroDeathSound = soundFolder .. "pahom/death.mp3"
--
---- epifanzev
--resources.epifanzevAttackSound = soundFolder .. "epifanzev/attack.mp3"
--resources.epifanzevPortBonusSound = soundFolder .. "epifanzev/portBonus.mp3"
--resources.epifanzevEpauletteBonusSound = soundFolder .. "epifanzev/epauletteBonus.mp3"
--resources.epifanzevForkBonusSound = soundFolder .. "epifanzev/forkBonus.mp3"
--resources.epifanzevCigaretteBonusSound = soundFolder .. "epifanzev/cigaretteBonus.mp3"
--resources.epifanzevCheckersBonusSound = soundFolder .. "epifanzev/checkersBonus.mp3"
--resources.epifanzevDeathSound = soundFolder .. "epifanzev/death.mp3"
--
---- maslaev
--resources.maslaevAttackSound = soundFolder .. "maslaev/attack.mp3"
--resources.maslaevPortBonusSound = soundFolder .. "maslaev/portBonus.mp3"
--resources.maslaevEpauletteBonusSound = soundFolder .. "maslaev/epauletteBonus.mp3"
--resources.maslaevForkBonusSound = soundFolder .. "maslaev/forkBonus.mp3"
--resources.maslaevCigaretteBonusSound = soundFolder .. "maslaev/cigaretteBonus.mp3"
--resources.maslaevCheckersBonusSound = soundFolder .. "maslaev/checkersBonus.mp3"
--resources.maslaevDeathSound = soundFolder .. "maslaev/death.mp3"
--
---- captain
--resources.captainAttackSound = soundFolder .. "captain/attack.mp3"
--resources.captainPortBonusSound = soundFolder .. "captain/portBonus.mp3"
--resources.captainEpauletteBonusSound = soundFolder .. "captain/epauletteBonus.mp3"
--resources.captainForkBonusSound = soundFolder .. "captain/forkBonus.mp3"
--resources.captainCigaretteBonusSound = soundFolder .. "captain/cigaretteBonus.mp3"
--resources.captainCheckersBonusSound = soundFolder .. "captain/checkersBonus.mp3"
--resources.captainDeathSound = soundFolder .. "captain/death.mp3"


-- NEW SECTION

-- lib scripts
resources.dataScript = "scripts.lib.GData"
resources.globalScript = "scripts.lib.GGlobal"
resources.musicScript = "scripts.lib.GMusic"
resources.soundScript = "scripts.lib.GSound"
resources.helpersScript = "scripts.lib.Helpers"
resources.buttonScript = "scripts.lib.GButton"
resources.colorScript = "scripts.lib.GColor"
resources.perspectiveScript = "scripts.lib.GPerspective"
resources.transitionScript = "scripts.lib.GTransition"
resources.classScript = "scripts.lib.Class"
-- lib scripts

-- system scripts
resources.preLoadScript = "scripts.classes.preLoad"
resources.globalOptionsScript = "scripts.classes.globalOptions"
-- system scripts

-- scene scrips
resources.menuScene = "scripts.scenes.menu"
resources.levelsListScene = "scripts.scenes.levelslist"
resources.shopScene = "scripts.scenes.shop"
resources.comicsScene = "scripts.scenes.comics"
resources.optionsScene = "scripts.scenes.options"
resources.gameScene = "scripts.scenes.game"
resources.pauseScene = "scripts.scenes.pause"
resources.gameoverScene = "scripts.scenes.gameover"
resources.gamewinScene = "scripts.scenes.gamewin"
resources.bonusesSelectScene = "scripts.scenes.bonusesselect"
resources.reloadingScene = "scripts.scenes.reloading"
-- scene scripts

-- base scripts

local baseScripts = "scripts.classes.base."

resources.base_menuControlScript = baseScripts .. "menuControl"
resources.base_gameControlScript = baseScripts .. "gameControl"
resources.base_gameObjectScript = baseScripts .. "gameObject"
resources.base_gameRectangleScript = baseScripts .. "gameRectangle"

-- base scripts

-- menu scripts
local menuScripts = "scripts.classes.menuArea."

resources.menu_menuAreaScript = "scripts.classes.menuArea"

resources.menu_mainMenuScript = menuScripts .. "mainMenu"
resources.menu_playButtonScript = menuScripts .. "mainMenu.playButton"
resources.menu_shopButtonScript = menuScripts .. "mainMenu.shopButton"
resources.menu_optionsButtonScript = menuScripts .. "mainMenu.optionsButton"
resources.menu_leaderboardButtonScript = menuScripts .. "mainMenu.leaderboardButton"
resources.menu_achievmentsButtonScript = menuScripts .. "mainMenu.achievmentsButton"
resources.menu_gameButtonScript = menuScripts .. "mainMenu.gameButton"
resources.menu_shopButtonScript = menuScripts .. "mainMenu.shopButton"
resources.menu_optionsButtonScript = menuScripts .. "mainMenu.optionsButton"
resources.menu_bonusCounterScript = menuScripts .. "mainMenu.bonusCounter"
resources.menu_pointsCounterScript = menuScripts .. "mainMenu.pointsCounter"

resources.menu_shopMenuScript = menuScripts .. "shopMenu"
resources.menu_backButtonScript = menuScripts .. "shopMenu.backButton"
resources.menu_buyButtonScript = menuScripts .. "shopMenu.buyButton"
resources.menu_shopItemScript = menuScripts .. "shopMenu.shopItem"
resources.menu_priceLabelScript = menuScripts .. "shopMenu.priceLabel"

resources.menu_optionsMenuScript = menuScripts .. "optionsMenu"
resources.menu_backButtonLargeScript = menuScripts .. "optionsMenu.backButtonLarge"
resources.menu_musicButtonLargeScript = menuScripts .. "optionsMenu.musicButtonLarge"
resources.menu_soundsButtonLargeScript = menuScripts .. "optionsMenu.soundsButtonLarge"

resources.menu_levelsListMenuScript = menuScripts .. "levelsListMenu"
resources.menu_prevLevelsListButtonScript = menuScripts .. "levelsListMenu.prevLevelsListButton"
resources.menu_nextLevelsListButtonScript = menuScripts .. "levelsListMenu.nextLevelsListButton"
resources.menu_levelsListPointScript = menuScripts .. "levelsListMenu.levelsListPoint"
resources.menu_levelItemScript = menuScripts .. "levelsListMenu.levelItem"
resources.menu_comicsButtonScript = menuScripts .. "levelsListMenu.comicsButton"

resources.menu_comicsMenuScript = menuScripts .. "comicsMenu"
resources.menu_comicsConfigScript = menuScripts .. "comicsConfig"
resources.menu_comicsSliderScript = menuScripts .. "comicsMenu.comicsSlider"
resources.menu_prevComicsButtonScript = menuScripts .. "comicsMenu.prevComicsButton"
resources.menu_nextComicsButtonScript = menuScripts .. "comicsMenu.nextComicsButton"

-- menu scripts

-- game scripts
local gameScripts = "scripts.classes.gameArea."

resources.game_fileModuleScript = "scripts.classes.fileModule"

resources.game_gameAreaScript = "scripts.classes.gameArea"

resources.game_gameTimerScript = gameScripts .. "gameTimer"

resources.game_gameChaptersConfigScript = gameScripts .. "gameChaptersConfig"

resources.game_gameHudScript = gameScripts .. "gameHud"
resources.game_pauseButtonScript = gameScripts .. "gameHud.pauseButton"
resources.game_controllerScript = gameScripts .. "gameHud.controller"
resources.game_bonusScript = gameScripts .. "gameHud.bonus"
resources.game_multipointTimerScript = gameScripts .. "gameHud.multipointTimer"
resources.game_bonusTimerScript = gameScripts .. "gameHud.bonusTimer"
resources.game_liveLevelScript = gameScripts .. "gameHud.liveLevel"
resources.game_pointsCounterScript = gameScripts .. "gameHud.pointsCounter"

resources.game_gameObjectsScript = gameScripts .. "gameObjects"
resources.game_blockScript = gameScripts .. "gameObjects.block"
resources.game_multipointScript = gameScripts .. "gameObjects.multipoint"
resources.game_enemyScript = gameScripts .. "gameObjects.enemy"
resources.game_playerScript = gameScripts .. "gameObjects.player"
resources.game_pointScript = gameScripts .. "gameObjects.point"

resources.game_pauseMenuScript = gameScripts .. "pauseMenu"
resources.game_backButtonLargeScript = gameScripts .. "pauseMenu.backButtonLarge"
resources.game_levelsListButtonLargeScript = gameScripts .. "pauseMenu.levelsListButtonLarge"
resources.game_optionsButtonLargeScript = gameScripts .. "pauseMenu.optionsButtonLarge"

resources.game_bonusesSelectMenuScript = gameScripts .. "bonusesSelectMenu"
resources.game_bonusSelectItemScript = gameScripts .. "bonusesSelectMenu.bonusSelectItem"
resources.game_applyButtonLargeScript = gameScripts .. "bonusesSelectMenu.applyButtonLarge"

resources.game_gameoverMenuScript = gameScripts .. "gameoverMenu"
resources.gameover_replayButtonLargeScript = gameScripts .. "gameoverMenu.replayButtonLarge"

resources.game_gamewinMenuScript = gameScripts .. "gamewinMenu"
resources.gamewin_nextLevelButtonLargeScript = gameScripts .. "gamewinMenu.nextLevelButtonLarge"
resources.gamewin_replayButtonLargeScript = gameScripts .. "gamewinMenu.replayButtonLarge"

-- shared game scripts

resources.game_gameTimeTextLabelScript = gameScripts .. "shared.gameTimeTextLabel"
resources.game_gameScoresTextLabelScript = gameScripts .. "shared.gameScoresTextLabel"
resources.game_levelsListButtonLargeScript = gameScripts .. "shared.levelsListButtonLarge"
        
-- shared game scripts

-- game scripts

-- IMAGES

-- menu Images
local menuImages = "assets/images/menu/"

resources.menu_mainMenuBackground = menuImages .. "mainMenuBackground.png"
resources.menu_playButton = menuImages .. "playButton.png"
resources.menu_shopButton = menuImages .. "shopButton.png"
resources.menu_optionsButton = menuImages .. "optionsButton.png"
resources.menu_leaderboardButton = menuImages .. "leaderboardButton.png"
resources.menu_achievmentsButton = menuImages .. "achievmentsButton.png"
resources.menu_backButton = menuImages .. "backButton.png"
resources.menu_buyButton = menuImages .. "buyButton.png"
resources.menu_bonus1 = menuImages .. "bonus1.png"
resources.menu_bonus2 = menuImages .. "bonus2.png"
resources.menu_bonus3 = menuImages .. "bonus3.png"
resources.menu_bonus4 = menuImages .. "bonus4.png"
resources.menu_bonus5 = menuImages .. "bonus5.png"
resources.menu_pointsCounter = menuImages .. "pointsCounter.png"

resources.menu_shopMenuBackground = menuImages .. "shopMenuBackground.png"
resources.menu_shopBack = menuImages .. "shopBack.png"
resources.menu_shopItem = menuImages .. "shopItem.png"
resources.menu_shopItemSelected = menuImages .. "shopItemSelected.png"

resources.menu_optionsMenuBackground = menuImages .. "optionsMenuBackground.png"
resources.menu_optionsMenuLabel = menuImages .. "optionsMenuLabel.png"
resources.menu_backButtonLarge = menuImages .. "backButtonLarge.png"
resources.menu_musicOnButtonLarge = menuImages .. "musicOnButtonLarge.png"
resources.menu_musicOffButtonLarge = menuImages .. "musicOffButtonLarge.png"
resources.menu_soundsOnButtonLarge = menuImages .. "soundsOnButtonLarge.png"
resources.menu_soundsOffButtonLarge = menuImages .. "soundsOffButtonLarge.png"

resources.menu_levelsListMenuBackground = menuImages .. "levelsListMenuBackground.png"
resources.menu_levelsListBack = menuImages .. "levelsListBack.png"
resources.menu_prevLevelsListButton = menuImages .. "prevLevelsListButton.png"
resources.menu_nextLevelsListButton = menuImages .. "nextLevelsListButton.png"
resources.menu_levelsListPoint = menuImages .. "levelsListPoint.png"
resources.menu_levelsListPointCurrent = menuImages .. "levelsListPointCurrent.png"
resources.menu_levelItem = menuImages .. "levelItem.png"
resources.menu_levelItemNumbers = menuImages
resources.menu_levelItemLock = menuImages .. "levelItemLock.png"
resources.menu_levelItemStar = menuImages .. "levelItemStar.png"

resources.menu_comicsButton1 = menuImages .. "comics1Button.png"
resources.menu_comicsButton1Locked = menuImages .. "comics1ButtonLocked.png"
resources.menu_comicsButton2 = menuImages .. "comics2Button.png"
resources.menu_comicsButton2Locked = menuImages .. "comics2ButtonLocked.png"
resources.menu_comicsButton3 = menuImages .. "comics3Button.png"
resources.menu_comicsButton3Locked = menuImages .. "comics3ButtonLocked.png"

resources.menu_prevComicsButton = menuImages .. "prevLevelsListButton.png"
resources.menu_nextComicsButton = menuImages .. "nextLevelsListButton.png"

local comicsItems = "assets/images/comics/"

resources.menu_chapter1_comics1 = comicsItems .. "chapter1/1.png"
resources.menu_chapter1_comics2 = comicsItems .. "chapter1/2.png"
resources.menu_chapter1_comics3 = comicsItems .. "chapter1/3.png"
resources.menu_chapter1_comics4 = comicsItems .. "chapter1/4.png"
resources.menu_chapter1_comics5 = comicsItems .. "chapter1/5.png"

resources.menu_chapter2_comics1 = comicsItems .. "chapter2/1.png"
resources.menu_chapter2_comics2 = comicsItems .. "chapter2/2.png"

resources.menu_chapter3_comics1 = comicsItems .. "chapter3/1.png"

resources.menu_final_comics1 = comicsItems .. "final/1.png"
resources.menu_final_comics2 = comicsItems .. "final/2.png"
resources.menu_final_comics3 = comicsItems .. "final/3.png"
resources.menu_final_comics4 = comicsItems .. "final/4.png"
resources.menu_final_comics5 = comicsItems .. "final/5.png"

resources.menu_layer = menuImages .. "layer.png"

-- menu Images

-- game Images

local gameImages = "assets/images/game/"

-- hud

resources.game_point = gameImages .. "hud/point.png"
resources.game_bonus = gameImages .. "bonus.png"
resources.game_bonus1 = gameImages .. "hud/bonus1.png"
resources.game_bonus2 = gameImages .. "hud/bonus2.png"
resources.game_bonus3 = gameImages .. "hud/bonus3.png"
resources.game_bonus4 = gameImages .. "hud/bonus4.png"
resources.game_bonus5 = gameImages .. "hud/bonus5.png"
resources.game_lowLive = gameImages .. "hud/lowLive.png"
resources.game_middleLive = gameImages .. "hud/middleLive.png"
resources.game_fullLive = gameImages .. "hud/fullLive.png"
resources.game_pauseButton = gameImages .. "hud/pauseButton.png"

-- hud

-- menus

resources.game_pauseMenuBackground = gameImages .. "menu/pauseMenuBackground.png"
resources.game_pauseMenuLabel = gameImages .. "menu/pauseMenuLabel.png"
resources.game_backButtonLarge = gameImages .. "menu/backButtonLarge.png"
resources.game_levelsListButtonLarge = gameImages .. "menu/levelsListButtonLarge.png"
resources.game_optionsButtonLarge = gameImages .. "menu/optionsButtonLarge.png"

resources.game_bonusSelectBack = gameImages .. "menu/bonusSelectBack.png"
resources.game_bonusSelectAlterBack = gameImages .. "menu/bonusSelectAlterBack.png"
resources.game_bonusSelectDisabledBack = gameImages .. "menu/bonusSelectDisabledBack.png"
resources.game_bonusSelect1 = gameImages .. "menu/bonus1Logo.png"
resources.game_bonusSelect2 = gameImages .. "menu/bonus2Logo.png"
resources.game_bonusSelect3 = gameImages .. "menu/bonus3Logo.png"
resources.game_bonusSelect4 = gameImages .. "menu/bonus4Logo.png"
resources.game_bonusSelect5 = gameImages .. "menu/bonus5Logo.png"
resources.game_applyButtonLarge = gameImages .. "menu/applyButtonLarge.png"

resources.game_gameoverMenuBackground = gameImages .. "menu/gameoverMenuBackground.png"
resources.game_replayButtonLarge = gameImages .. "menu/replayButtonLarge.png"

resources.game_gamewinMenuBackground = gameImages .. "menu/gamewinMenuBackground.png"
resources.game_nextLevelButtonLarge = gameImages .. "menu/nextLevelButtonLarge.png"


-- menus

-- chapter 1

resources.game_chapter1_gameBackground = gameImages .. "chapter1/background.png"
resources.game_chapter1_point = gameImages .. "chapter1/point.png"
resources.game_chapter1_multipoint = gameImages .. "chapter1/multipoint.png"
resources.game_chapter1_angle = gameImages .. "chapter1/angle.png"
resources.game_chapter1_angleCircle = gameImages .. "chapter1/angleCircle.png"
resources.game_chapter1_line = gameImages .. "chapter1/line.png"
resources.game_chapter1_lineCircle = gameImages .. "chapter1/lineCircle.png"
resources.game_chapter1_triangle = gameImages .. "chapter1/triangle.png"
resources.game_chapter1_triangle90 = gameImages .. "chapter1/triangle90.png"
resources.game_chapter1_triangleCircle = gameImages .. "chapter1/triangleCircle.png"
resources.game_chapter1_triangleCircle90 = gameImages .. "chapter1/triangleCircle90.png"
resources.game_chapter1_tetra = gameImages .. "chapter1/tetra.png"
resources.game_chapter1_controller = gameImages .. "chapter1/controller.png"

resources.game_chapter1_playerIdle = gameImages .. "chapter1/playerIdle.png"
resources.game_chapter1_playerActive = gameImages .. "chapter1/playerActive.png"
resources.game_chapter1_playerAngry = gameImages .. "chapter1/playerAngry.png"
resources.game_chapter1_playerWound = gameImages .. "chapter1/playerWound.png"

resources.game_chapter1_russianEnemyIdle = gameImages .. "chapter1/russianEnemyIdle.png"
resources.game_chapter1_russianEnemyActive = gameImages .. "chapter1/russianEnemyActive.png"
resources.game_chapter1_russianEnemyAngry = gameImages .. "chapter1/russianEnemyAngry.png"
resources.game_chapter1_russianEnemyFear = gameImages .. "chapter1/russianEnemyFear.png"
resources.game_chapter1_russianEnemyWound = gameImages .. "chapter1/russianEnemyWound.png"

resources.game_chapter1_germanEnemyIdle = gameImages .. "chapter1/germanEnemyIdle.png"
resources.game_chapter1_germanEnemyActive = gameImages .. "chapter1/germanEnemyActive.png"
resources.game_chapter1_germanEnemyAngry = gameImages .. "chapter1/germanEnemyAngry.png"
resources.game_chapter1_germanEnemyFear = gameImages .. "chapter1/germanEnemyFear.png"
resources.game_chapter1_germanEnemyWound = gameImages .. "chapter1/germanEnemyWound.png"

resources.game_chapter1_ufoEnemyIdle = gameImages .. "chapter1/ufoEnemyIdle.png"
resources.game_chapter1_ufoEnemyActive = gameImages .. "chapter1/ufoEnemyActive.png"
resources.game_chapter1_ufoEnemyAngry = gameImages .. "chapter1/ufoEnemyAngry.png"
resources.game_chapter1_ufoEnemyFear = gameImages .. "chapter1/ufoEnemyFear.png"
resources.game_chapter1_ufoEnemyWound = gameImages .. "chapter1/ufoEnemyWound.png"
-- chapter 1

-- chapter 2

resources.game_chapter2_gameBackground = gameImages .. "chapter2/background.png"
resources.game_chapter2_point = gameImages .. "chapter2/point.png"
resources.game_chapter2_multipoint = gameImages .. "chapter2/multipoint.png"
resources.game_chapter2_angle = gameImages .. "chapter2/angle.png"
resources.game_chapter2_angleCircle = gameImages .. "chapter2/angleСircle.png"
resources.game_chapter2_line = gameImages .. "chapter2/line.png"
resources.game_chapter2_lineCircle = gameImages .. "chapter2/lineCircle.png"
resources.game_chapter2_triangle = gameImages .. "chapter2/triangle.png"
resources.game_chapter2_triangle90 = gameImages .. "chapter2/triangle90.png"
resources.game_chapter2_triangleCircle = gameImages .. "chapter2/triangleCircle.png"
resources.game_chapter2_triangleCircle90 = gameImages .. "chapter2/triangleCircle90.png"
resources.game_chapter2_tetra = gameImages .. "chapter2/tetra.png"
resources.game_chapter2_controller = gameImages .. "chapter2/controller.png"

resources.game_chapter2_playerIdle = gameImages .. "chapter2/playerIdle.png"
resources.game_chapter2_playerActive = gameImages .. "chapter2/playerActive.png"
resources.game_chapter2_playerAngry = gameImages .. "chapter2/playerAngry.png"
resources.game_chapter2_playerWound = gameImages .. "chapter2/playerWound.png"

resources.game_chapter2_russianEnemyIdle = gameImages .. "chapter2/russianEnemyIdle.png"
resources.game_chapter2_russianEnemyActive = gameImages .. "chapter2/russianEnemyActive.png"
resources.game_chapter2_russianEnemyAngry = gameImages .. "chapter2/russianEnemyAngry.png"
resources.game_chapter2_russianEnemyFear = gameImages .. "chapter2/russianEnemyFear.png"
resources.game_chapter2_russianEnemyWound = gameImages .. "chapter2/russianEnemyWound.png"

resources.game_chapter2_germanEnemyIdle = gameImages .. "chapter2/germanEnemyIdle.png"
resources.game_chapter2_germanEnemyActive = gameImages .. "chapter2/germanEnemyActive.png"
resources.game_chapter2_germanEnemyAngry = gameImages .. "chapter2/germanEnemyAngry.png"
resources.game_chapter2_germanEnemyFear = gameImages .. "chapter2/germanEnemyFear.png"
resources.game_chapter2_germanEnemyWound = gameImages .. "chapter2/germanEnemyWound.png"

resources.game_chapter2_ufoEnemyIdle = gameImages .. "chapter2/ufoEnemyIdle.png"
resources.game_chapter2_ufoEnemyActive = gameImages .. "chapter2/ufoEnemyActive.png"
resources.game_chapter2_ufoEnemyAngry = gameImages .. "chapter2/ufoEnemyAngry.png"
resources.game_chapter2_ufoEnemyFear = gameImages .. "chapter2/ufoEnemyFear.png"
resources.game_chapter2_ufoEnemyWound = gameImages .. "chapter2/ufoEnemyWound.png"

-- chapter 2

-- chapter 3

resources.game_chapter3_gameBackground = gameImages .. "chapter3/background.png"
resources.game_chapter3_point = gameImages .. "chapter3/point.png"
resources.game_chapter3_multipoint = gameImages .. "chapter3/multipoint.png"
resources.game_chapter3_angle = gameImages .. "chapter3/angle.png"
resources.game_chapter3_angleCircle = gameImages .. "chapter3/angleCircle.png"
resources.game_chapter3_line = gameImages .. "chapter3/line.png"
resources.game_chapter3_lineCircle = gameImages .. "chapter3/lineCircle.png"
resources.game_chapter3_triangle = gameImages .. "chapter3/triangle.png"
resources.game_chapter3_triangle90 = gameImages .. "chapter3/triangle90.png"
resources.game_chapter3_triangleCircle = gameImages .. "chapter3/triangleCircle.png"
resources.game_chapter3_triangleCircle90 = gameImages .. "chapter3/triangleCircle90.png"
resources.game_chapter3_tetra = gameImages .. "chapter3/tetra.png"
resources.game_chapter3_controller = gameImages .. "chapter3/controller.png"

resources.game_chapter3_playerIdle = gameImages .. "chapter3/playerIdle.png"
resources.game_chapter3_playerActive = gameImages .. "chapter3/playerActive.png"
resources.game_chapter3_playerAngry = gameImages .. "chapter3/playerAngry.png"
resources.game_chapter3_playerWound = gameImages .. "chapter3/playerWound.png"

resources.game_chapter3_russianEnemyIdle = gameImages .. "chapter3/russianEnemyIdle.png"
resources.game_chapter3_russianEnemyActive = gameImages .. "chapter3/russianEnemyActive.png"
resources.game_chapter3_russianEnemyAngry = gameImages .. "chapter3/russianEnemyAngry.png"
resources.game_chapter3_russianEnemyFear = gameImages .. "chapter3/russianEnemyFear.png"
resources.game_chapter3_russianEnemyWound = gameImages .. "chapter3/russianEnemyWound.png"

resources.game_chapter3_germanEnemyIdle = gameImages .. "chapter3/germanEnemyIdle.png"
resources.game_chapter3_germanEnemyActive = gameImages .. "chapter3/germanEnemyActive.png"
resources.game_chapter3_germanEnemyAngry = gameImages .. "chapter3/germanEnemyAngry.png"
resources.game_chapter3_germanEnemyFear = gameImages .. "chapter3/germanEnemyFear.png"
resources.game_chapter3_germanEnemyWound = gameImages .. "chapter3/germanEnemyWound.png"

resources.game_chapter3_ufoEnemyIdle = gameImages .. "chapter3/ufoEnemyIdle.png"
resources.game_chapter3_ufoEnemyActive = gameImages .. "chapter3/ufoEnemyActive.png"
resources.game_chapter3_ufoEnemyAngry = gameImages .. "chapter3/ufoEnemyAngry.png"
resources.game_chapter3_ufoEnemyFear = gameImages .. "chapter3/ufoEnemyFear.png"
resources.game_chapter3_ufoEnemyWound = gameImages .. "chapter3/ufoEnemyWound.png"

-- chapter 3

-- game Images

-- NEW SECTION

return resources
