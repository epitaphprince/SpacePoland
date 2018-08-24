-- global class definition

local Base

function Class(Super)
   Super = Super or Base
   local prototype = setmetatable({}, Super)
   prototype.type = type
   prototype.class = prototype
   prototype.super = Super
   prototype.__index = prototype
   return prototype
end

Base = Class()

function Base:new(config)
    local instance = setmetatable({}, self) --decorate instance with class attr
    if(config) then
        instance:initialize(config)
    else
        instance:initialize()
    end
    
   if (self.Instances) then table.insert(self.Instances, instance) end
   return instance
end

function Base:initialize() end

function Base:get()
	local Instances = self.Instances
	if (not Instances[1]) then local obj = self:new() end
	return table.remove(Instances, 1)
end

function Base:dispose()
--    table.insert(self.Instances, self)
    self = nil
end
