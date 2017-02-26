local Entity = require('lib.entity')

local Star = Entity:extend()

function Star:new(opts)
  self.opacity = math.random() * 200 + 55
  self.x = opts.x
  self.y = opts.y
end

function Star:draw()
  love.graphics.setColor(255,255,255, self.opacity)
  love.graphics.points(self.x, self.y)
end

return Star
