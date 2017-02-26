local config = require('lib.config')
local Entity = require('lib.entity')
local signal = require('vendor.signal')

local Stats = Entity:extend()

function Stats:new()
  self.days  = 0
  self.kills = 0
  signal.register('bomber:die', function() self.kills = self.kills + 1 end)
end

function Stats:draw()
  love.graphics.reset()
  love.graphics.setColor(0, 0, 0, 255 * .75)
  love.graphics.rectangle('fill', 5, 5, 110, 65, 2)
  love.graphics.setColor(255, 255, 255)
  love.graphics.print(string.format('survived: %.1f days', self.days), 10, 10)
  love.graphics.print(string.format('kills: %s', self.kills), 10, 30)
end

function Stats:update(dt)
  self.days = self.days + dt * config.days / config.seconds
end

return Stats
