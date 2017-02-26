local config = require('lib.config')
local Entity = require('lib.entity')

local daysPerSecond = config.days / config.seconds

local Planet = Entity:extend()

function Planet:new(opts)
  self.d    = opts.d * 6000 -- distance to sun
  self.name = opts.name
  self.r    = opts.r * 8    -- planetary radius
  self.sun  = opts.sun
  self.t    = opts.t        -- angle of revolution
  self.w    = opts.w        -- angular velocity
end

function Planet:draw()
  love.graphics.setColor(0,150,0)
  love.graphics.circle('fill', self:x(), self:y(), self.r)
end

function Planet:project(dt)
  local t = self.t + self.w * dt * daysPerSecond
  local x = self.sun.x + self.d * math.cos(t)
  local y = self.sun.y + self.d * math.sin(t)
  return x, y
end

function Planet:update(dt)
  self.t = self.t + self.w * dt * daysPerSecond
end

function Planet:x()
  return self.sun.x + self.d * math.cos(self.t)
end

function Planet:y()
  return self.sun.y + self.d * math.sin(self.t)
end

return Planet
