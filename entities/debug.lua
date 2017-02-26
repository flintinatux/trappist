local Entity = require('lib.entity')

local Debug = Entity:extend()

function Debug:draw()
  local stats = love.graphics.getStats()
  love.graphics.reset()
  love.graphics.setColor(0, 0, 0, 255 * .75)
  love.graphics.rectangle('fill', 5, 5, 110, 65, 2)
  love.graphics.setColor(255, 255, 255)
  love.graphics.print(love.timer.getFPS() .. 'fps', 10, 10)
  love.graphics.print('drawcalls: ' .. stats.drawcalls, 10, 30)
end

return Debug()
