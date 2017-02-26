local Entity = require('lib.entity')

local Bullet = Entity:extend()

function Bullet:new(opts)
  self.x  = opts.x
  self.y  = opts.y
  self.vx = opts.vx
  self.vy = opts.vy
end

function Bullet:draw()
  love.graphics.setColor(255, 255, 0)
  love.graphics.circle('fill', self.x, self.y, 3)
end

function Bullet:update(dt)
  self.x = self.x + self.vx * dt
  self.y = self.y + self.vy * dt

  local w, h = love.graphics.getDimensions()
  if self.x < 0 or self.x > w or self.y < 0 or self.y > h then
    self.list:remove(self)
  end
end

return Bullet
