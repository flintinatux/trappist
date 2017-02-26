local Entity = require('lib.entity')
local shash  = require('lib.shash')

local r = 3

local Bullet = Entity:extend()

function Bullet:new(opts)
  self.x  = opts.x
  self.y  = opts.y
  self.vx = opts.vx
  self.vy = opts.vy
  shash.add(self)
end

function Bullet:bbox()
  return self.x - r, self.y - r, 2 * r, 2 * r
end

function Bullet:die()
  self.list:remove(self)
  shash.remove(self)
end

function Bullet:draw()
  love.graphics.setColor(255, 255, 0)
  love.graphics.circle('fill', self.x, self.y, r)
end

function Bullet:update(dt)
  self.x = self.x + self.vx * dt
  self.y = self.y + self.vy * dt
  shash.update(self)

  shash.each(self, function(o)
    if o.enemy then
      o:hit()
      self:die()
    end
  end)

  local w, h = love.graphics.getDimensions()
  if self.x < 0 or self.x > w or self.y < 0 or self.y > h then
    self:die()
  end
end

return Bullet
