local Entity = require('lib.entity')
local signal = require('vendor.signal')

local vbullet = 300

local Gun = Entity:extend()

function Gun:new(opts)
  self.nearest   = next(opts.planets)
  self.planets   = opts.planets
  self.x, self.y = love.mouse.getPosition()
  signal.register('shoot', bind(self.shoot, self))
end

function Gun:draw()
  local x, y = self.x, self.y

  -- reticle
  love.graphics.setColor(255,255,255)
  love.graphics.setLineWidth(1)
  love.graphics.line(x, y-10, x, y+10)
  love.graphics.line(x-10, y, x+10, y)

  -- line of fire
  love.graphics.setColor(255,255,255,35)
  love.graphics.setLineWidth(1)
  love.graphics.line(self.nearest:x(), self.nearest:y(), x, y)
end

function Gun:shoot(x, y)
  local px, py = self.nearest:x(), self.nearest:y()
  local t = math.atan2(y - py, x - px)
  signal.emit('bullet', {
    x  = px,
    y  = py,
    vx = vbullet * math.cos(t),
    vy = vbullet * math.sin(t)
  })
end

function Gun:update()
  self.x, self.y = love.mouse.getPosition()

  -- find nearest planet
  local d1, d2, nearest = math.huge
  self.planets:each(function(p)
    d2 = (self.x - p:x())^2 + (self.y - p:y())^2
    if d2 < d1 then
      nearest = p
      d1 = d2
    end
  end)
  self.nearest = nearest
end

return Gun
