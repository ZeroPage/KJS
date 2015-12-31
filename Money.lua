Money = {balance = 0}

function Money:new(o)	
    o = o or {}

    setmetatable(o, self)
    self.__index = self

    return o
end

function Money:set(v)
    self.balance = v
end

function Money:get()
	return self.balance
end

