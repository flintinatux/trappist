local Entity  = require('lib.entity')

local Sun = Entity:extend()

function Sun:new(opts)
  self.r = opts.r
  self.x = opts.x
  self.y = opts.y
end

function Sun:draw()
  love.graphics.setColor(150,0,0)
  love.graphics.circle('fill', self.x, self.y, self.r)
end

return Sun
