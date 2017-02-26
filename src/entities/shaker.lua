local Entity = require('lib.entity')
local signal = require('vendor.signal')

local magnitude = 5

local Shaker = Entity:extend()

function Shaker:new()
  self.dur  = 0
  self.time = 0
end

function Shaker:draw()
  if self.time < self.dur then
    local dx = math.random(-magnitude, magnitude)
    local dy = math.random(-magnitude, magnitude)
    love.graphics.translate(dx, dy)
  else
    love.graphics.translate(0, 0)
  end
end

function Shaker:shake(dur)
  self.dur  = dur
  self.time = 0
end

function Shaker:update(dt)
  if self.time < self.dur then
    self.time = self.time + dt
  end
end

local shaker = Shaker()

signal.register('planet:hit', function()
  shaker:shake(0.4)
end)

return shaker
