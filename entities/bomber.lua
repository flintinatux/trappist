local Entity = require('lib.entity')
local shaker = require('entities.shaker')
local shash  = require('lib.shash')
local signal = require('vendor.signal')

local w, h = 20, 12

local Bomber = Entity:extend()

function Bomber:new(opts)
  self.enemy = true
  self.x  = opts.x
  self.y  = opts.y
  self.vx = opts.vx
  self.vy = opts.vy
  shash.add(self)
end

function Bomber:bbox()
  return self.x - w/2, self.y - h/2, w, h
end

function Bomber:die()
  self.list:remove(self)
  shash.remove(self)
  shaker:shake(0.15)
  signal.emit('bomber:die')
  -- show explosion
end

function Bomber:draw()
  local verts = {
    self.x,       self.y - h/2,
    self.x + w/2, self.y,
    self.x,       self.y + h/2,
    self.x - w/2,  self.y
  }
  love.graphics.setColor(255,0,0)
  love.graphics.polygon('line', verts)
  love.graphics.setColor(255,0,0,70)
  love.graphics.polygon('fill', verts)
end

function Bomber:hit()
  -- play sound
  self:die()
end

function Bomber:update(dt)
  self.x = self.x + self.vx * dt
  self.y = self.y + self.vy * dt
  shash.update(self)

  shash.each(self, function(o)
    if o.planet then
      o:hit()
      self:die()
    end
  end)
end

return Bomber
