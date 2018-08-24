-- global helpers. 

-- Return first argument from list that is not nil.
function fnn( ... ) 
        for i = 1, #arg do
            local theArg = arg[i]
            if(theArg ~= nil) then return theArg end
        end
        return nil
end

-- For loops
function cycle(current, count, step)
    local num = current + step

    if(num > count) then
        num = num - count
    end
    return num 
end

-- read data from level file and split them
function split(pString, pPattern)
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

-- read level data

function readLevel(levelName)
	local levelData = {};
	local path = system.pathForFile(R.levelFolder .. levelName);
	file = io.open( path, "r");

	for line in file:lines( ) do
        table.insert(levelData, line);
	end

	io.close( file )
	file = nil;

	return levelData;
end

-- table functions 

function table.deepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[table.deepCopy(orig_key)] = table.deepCopy(orig_value)
        end
        setmetatable(copy, table.deepCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function table.merge(t1, t2)
    for k,v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                table.merge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end