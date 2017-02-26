local stats = require('entities.stats')

local graphics = love.graphics

local big    = graphics.newFont(24)
local little = graphics.newFont(18)

local Ending = {}

function Ending:draw()
  local w, h = graphics.getDimensions()
  graphics.setColor(0,255,0,150)
  graphics.setFont(big)
  graphics.printf('CONGRATULATIONS!', 0, 200, w, 'center')
  graphics.setColor(255,255,255,150)
  graphics.setFont(little)
  graphics.printf('you survived', 0, 250, w, 'center')
  graphics.setColor(255,255,255,255)
  graphics.setFont(big)
  graphics.printf(string.format('%.1f days', stats.days), 0, 275, w, 'center')
  graphics.setColor(255,255,255,150)
  graphics.setFont(little)
  graphics.printf('you killed', 0, 325, w, 'center')
  graphics.setColor(255,255,255,255)
  graphics.setFont(big)
  graphics.printf(string.format('%s enemies', stats.kills), 0, 350, w, 'center')
  graphics.setColor(255,255,0,150)
  graphics.setFont(big)
  graphics.printf('THANKS FOR PLAYING!', 0, 400, w, 'center')
end

return Ending
