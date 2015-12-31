Button = {balance = 0}

function Button:new(o)
    o = o or {}

    setmetatable(o, self)
    self.__index = self

    return o
end

function Button:set(v)
    self.balance = v
end

function Button:get()
	return self.balance
end

setmetatable(o, self)