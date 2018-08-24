-- File Operations Module
local game = game
local fileModule = {};
local levelPath = "levels/" .. game.selectedLevel .. ".ml"

-- Split string into table
local function split(pString, pPattern)
   local Table = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pPattern
   local last_end = 1
   local s, e, cap = pString:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
         table.insert(Table,cap)
      end
      last_end = e+1
      s, e, cap = pString:find(fpat, last_end)
   end
   if last_end <= #pString then
      cap = pString:sub(last_end)
      table.insert(Table, cap)
   end
 
   return Table
end

-- Open level function
local function readLevel()
    local levelData = {}
    
    local path = system.pathForFile(levelPath)
    local file = io.open( path, "r")

    for line in file:lines( ) do
        local lineElement = split(line, "|")
        local element = {}
        element.type = lineElement[1]
        element.x = lineElement[2] * GlobalOptions.gameElementSize
        element.y = lineElement[3] * GlobalOptions.gameElementSize
        element.angle = tonumber(lineElement[4])
        table.insert(levelData, element);
    end

    io.close( file )
    file = nil;

    return levelData;
end

game.levelData = readLevel()

game:addEventListener("onGameEvent", fileModule)
function fileModule:onGameEvent(event)
    local phase = event.phase
    if(phase == "game") then
        
    end
    if(phase == "changeScene") then
        game:removeEventListener("onGameEvent", self)
        package.loaded[R.game_fileModuleScript] = nil
    end
end

return fileModule;




