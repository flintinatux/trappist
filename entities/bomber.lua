local Entity = require('lib.entity')

local Bomber = Entity:extend()

function Bomber:new(opts)
  self.x  = opts.x
  self.y  = opts.y
  self.vx = opts.vx
  self.vy = opts.vy
end

function Bomber:draw()
  local verts = {
    self.x,      self.y - 6,
    self.x + 10, self.y,
    self.x,      self.y + 6,
    self.x - 10, self.y
  }
  love.graphics.setColor(255,0,0)
  love.graphics.polygon('line', verts)
  love.graphics.setColor(255,0,0,70)
  love.graphics.polygon('fill', verts)
end

function Bomber:hit()
  self.list:remove(self)
end

function Bomber:update(dt)
  self.x = self.x + self.vx * dt
  self.y = self.y + self.vy * dt
end

return Bomber
