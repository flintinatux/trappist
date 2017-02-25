local Entity = require('lib.entity')

local Planet = Entity:extend()

function Planet:new(opts)
  self.d    = opts.d * 6000 -- distance to sun
  self.name = opts.name
  self.r    = opts.r * 8    -- planet radius
  self.sun  = opts.sun
  self.t    = opts.t        -- initial angle of revolution
  self.w    = opts.w        -- angular velocity
end

function Planet:update(dt)
  self.t = self.t - self.w * dt * 0.24
end

function Planet:draw()
  love.graphics.setColor(0,150,0)
  local x = self.sun.x + self.d * math.cos(self.t)
  local y = self.sun.y + self.d * math.sin(self.t)
  love.graphics.circle('fill', x, y, self.r)
end

return Planet
