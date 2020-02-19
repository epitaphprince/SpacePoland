-- constants
GlobalOptions =
{
    -- menu
    selectedScreen = 1,
    levelsCount = 36,
    levelsScreenCount = 3,
    levelsOnScreen = 12,
    levelScreenDelay = 500,
    currentChapter = 1,
    currentComics = 1,
    -- game
    pause = false,
    gameStart = false,
    maxBonuses = 3,
    gameElementSize = G.w / 15,
    gameElementOffset = G.w / 30,
    swipeSensitivity = 2,
    line = "line",
    lineCircle = "lineCircle",
    angle = "angle",
    angleCircle = "angleCircle",
    point = "point",
    multipoint = "multipoint",
    triangle = "triangle",
    triangle90 = "triangle90",
    triangleCircle = "triangleCircle",
    triangleCircle90 = "triangleCircle90",
    tetra = "tetra",
    germanEnemy = "germanEnemy",
    russianEnemy = "russianEnemy",
    ufoEnemy = "ufoEnemy",
    player = "player",

    -- variables
    objectsToWin = 0,
    pointsToRussianAttack = 0,
    pointsToGermanAttack = 0,
    pointsToUfoAttack = 0,
    totalPoints = 0,
    levelPoints = 0,
    gameTime = 0,
    playerLives = 3,
    
    variables = {
        activeBonus = false
    },

    attacks = {
        russian = false,
        german = false,
        ufo = false
    },

    -- events
    getPointEvent = "getPoint",
    getMultipointEvent = "getMultipoint",
    -- player
    movePlayerTopLeftAreaEvent = "movePlayerTopLeftArea",
    movePlayerTopRightAreaEvent = "movePlayerTopRightArea",
    movePlayerBottomLeftAreaEvent = "movePlayerBottomLeftArea",
    movePlayerBottomRightAreaEvent = "movePlayerBottomRightArea",
    -- enemy
    moveEnemyEvent = "moveEnemy",
    moveEnemyTopLeftAreaEvent = "moveEnemyTopLeftArea",
    moveEnemyTopRightAreaEvent = "moveEnemyTopRightArea",
    moveEnemyBottomLeftAreaEvent = "moveEnemyBottomLeftArea",
    moveEnemyBottomRightAreaEvent = "moveEnemyBottomRightArea",
    -- static objects
    multipointActivationEvent = "multipointActivation",
    changeStateEvent = "changeState",
    changeInteractionEvent = "changeInteraction",
    bonusActivationEvent = "bonusActivation",
    bonusActivationStartEvent = "bonusActivationStart",
    decreaseLivePointsEvent = "decreaseLivePoints",
    increaseLivePointsEvent = "increaseLivePoints",
    selectBonusesEvent = "selectBonuses",
    multipointTimeDestroy = "multipointTimeDestroy",
    gameWinEvent = "gameWin",
    gameOverEvent = "gameOver",

    axis = {
        y = (G.w / 15) * 9.5,
        x = (G.w / 15) * 7.5
    },
    directions = {
        up = "up",
        down = "down",
        left = "left",
        right = "right"
    },
    bonusTypes = {
        increasePlayerSpeed = "increasePlayerSpeed",
        playerImmortal = "playerImmortal",
        decreaseEnemiesSpeed = "decreaseEnemiesSpeed",
        doubleCoins = "doubleCoins",
        stoleLive = "stoleLive"
    },
    enemyState = {
        normal = "normal",
        attack = "attack",
        fear = "fear",
        wound = "wound",
        immortal = "immortal"
    },
    bonusState = {
        activation = "activation",
        deactivation = "deactivation"
    },
    playerState = {
        normal = "normal",
        wound = "wound",
        immortal = "immortal"
    },
    eventType = {
        collision = "collision",
        newDirection = "newDirection",
        fear = "fearDirection"
    },
    bonusType = {
        multipoint = "multipoint"
    },
    multipointTime = 10,
    bonusTime = 20,

    -- timers
    playerImmortalTime = 5000,
    enemyImmortalTime = 3000,
    playerWoundTime = 3000,
    enemyWoundTime = 3000,
    bonusActivationTime = 20000
}
