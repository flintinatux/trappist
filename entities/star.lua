local Entity = require('lib.entity')

local point = love.graphics.newImage('assets/point.png')

local Star = Entity:extend()

function Star:new(opts)
  self.opacity = math.random() * 200 + 55
  self.x = opts.x
  self.y = opts.y
end

function Star:draw()
  love.graphics.setColor(255,255,255, self.opacity)
  love.graphics.draw(point, self.x, self.y)
end

return Star
