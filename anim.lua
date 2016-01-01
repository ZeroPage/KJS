local anim = {
  _VERSION     = 'anim8 v2.2.0',
  _DESCRIPTION = 'An animation library for LÖVE',
  _URL         = 'https://github.com/kikito/anim8',
  _LICENSE     = [[
    MIT LICENSE
    Copyright (c) 2011 Enrique García Cota
    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:
    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ]]
}


local Animation = {}
local Animationmt = { __index = Animation }


local function parseDurations(durations, frameCount)
  local result = {}
  if type(durations) == 'number' then
    for i=1,frameCount do result[i] = durations end
  else
    local min, max, step
    for key,duration in pairs(durations) do
      assert(type(duration) == 'number', "The value [" .. tostring(duration) .. "] should be a number")
      min, max, step = parseInterval(key)
      for i = min,max,step do result[i] = duration end
    end
  end

  if #result < frameCount then
    error("The durations table has length of " .. tostring(#result) .. ", but it should be >= " .. tostring(frameCount))
  end

  return result

end

local function parseIntervals(durations)
  local result, time = {0},0
  for i=1,#durations do
    time = time + durations[i]
    result[i+1] = time
  end
  return result, time
end



local function newAnimation(durations, onLoop, ...)
	local images= {...}
  local td = type(durations);
  if (td ~= 'number' or durations <= 0) and td ~= 'table' then
    error("durations must be a positive number. Was " .. tostring(durations) )
  end
  onLoop = onLoop or nop
  durations = parseDurations(durations, 4)
  local intervals, totalDuration = parseIntervals(durations)
  return setmetatable({
      frames         = images,
      durations      = durations,
      intervals      = intervals,
      totalDuration  = totalDuration,
      onLoop         = onLoop,
      timer          = 0,
      timer2         = 0,
      position       = 1,
      status         = "playing",
      flippedH       = false,
      flippedV       = false,
      x              = love.math.random(0, 800),
      y              = 584,
      dx             = 1

    },
    Animationmt
  )

end


function Animation:draw()
  local image = self.frames[self.position]
  love.graphics.draw(image, self.x, self.y, r, sx, sy, ox, oy)
end


function Animation:update(dt)
  if self.status ~= "playing" then return end
  self.timer = self.timer + dt
  self.timer2 = self.timer2 +dt

  if self.timer > 1 then
    self.x = self.x + self.dx
    if self.position == 1 then
      self.position = 2
    else 
      self.position = 1
    end
    self.timer = 0
  else
  end

  if self.timer2 > 3 then
    self.dx = love.math.random(-7, 7)
    self.timer2 = 0
  else
  end
end


anim.newAnimation  = newAnimation

return anim
