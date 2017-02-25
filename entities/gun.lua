local Entity = require('lib.entity')

local Gun = Entity:extend()

function Gun:new(opts)
  self.nearest   = opts.planets[1]
  self.planets   = opts.planets
  self.x, self.y = love.mouse.getPosition()
end

function Gun:draw()
  local x, y = self.x, self.y

  -- reticle
  love.graphics.setColor(255,255,255)
  love.graphics.setLineWidth(2)
  love.graphics.line(x, y-10, x, y+10)
  love.graphics.line(x-10, y, x+10, y)

  -- line of fire
  love.graphics.setColor(255,255,255,70)
  love.graphics.setLineWidth(1)
  love.graphics.line(self.nearest:x(), self.nearest:y(), x, y)
end

function Gun:update(dt)
  self.x, self.y = love.mouse.getPosition()

  -- find nearest planet
  local d1, d2, nearest = math.huge
  for _, p in ipairs(self.planets) do
    d2 = (self.x - p:x())^2 + (self.y - p:y())^2
    if d2 < d1 then
      nearest = p
      d1 = d2
    end
  end
  self.nearest = nearest
end

return Gun
