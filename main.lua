require('lib.util').import()

local Bullets = require('entities.bullets')
local defs    = require('lib.planet-defs')
local Gun     = require('entities.gun')
local List    = require('lib.list')
local Planet  = require('entities.planet')
local signal  = require('vendor.signal')
local Sun     = require('entities.sun')

love.mouse.setVisible(false)

local w, h = love.graphics.getDimensions()

local sun = Sun({
  r = 10,
  x = w/2,
  y = h/2
})

local planets = List(compose(Planet, assoc('sun', sun)))
planets:load(defs)
local gun = Gun({ planets = planets })
local bullets = Bullets()

function love.draw()
  bullets:draw()
  gun:draw()
  planets:draw()
  sun:draw()

  -- Draw debug information in corner
  local stats = love.graphics.getStats()
  love.graphics.reset()
  love.graphics.setColor(0, 0, 0, 255 * .75)
  love.graphics.rectangle('fill', 5, 5, 110, 65, 2)
  love.graphics.setColor(255, 255, 255)
  love.graphics.print(love.timer.getFPS() .. 'fps', 10, 10)
  love.graphics.print('drawcalls: ' .. stats.drawcalls, 10, 30)
  love.graphics.print('bullets: ' .. #bullets, 10, 50)
end

function love.mousepressed(x, y)
  signal.emit('shoot', x, y)
end

function love.update(dt)
  if dt > 0.04 then return end
  bullets:update(dt)
  gun:update(dt)
  planets:update(dt)
  sun:update(dt)
end
