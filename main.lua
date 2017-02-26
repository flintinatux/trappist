require('lib.util').import()
math.randomseed(os.time())

local bullets = require('entities.bullets')()
local defs    = require('lib.planet-defs')
local Enemies = require('entities.enemies')
local Gun     = require('entities.gun')
local List    = require('lib.list')
local Planet  = require('entities.planet')
local signal  = require('vendor.signal')
local Star    = require('entities.star')
local Sun     = require('entities.sun')

love.mouse.setVisible(false)

local w, h = love.graphics.getDimensions()

local sun = Sun({ r = 10, x = w/2, y = h/2 })
local planets = List(compose(Planet, assoc('sun', sun)))
planets:load(defs)
local enemies = Enemies({ planets = planets })
local gun = Gun({ planets = planets })

local stars = List(Star)
for _ = 1, 400 do
  stars:insert({
    x = math.random() * w,
    y = math.random() * h
  })
end

function love.draw()
  bullets:draw()
  enemies:draw()
  gun:draw()
  planets:draw()
  stars:draw()
  sun:draw()

  -- Draw debug information in corner
  local stats = love.graphics.getStats()
  love.graphics.reset()
  love.graphics.setColor(0, 0, 0, 255 * .75)
  love.graphics.rectangle('fill', 5, 5, 110, 65, 2)
  love.graphics.setColor(255, 255, 255)
  love.graphics.print(love.timer.getFPS() .. 'fps', 10, 10)
  love.graphics.print('drawcalls: ' .. stats.drawcalls, 10, 30)
end

function love.mousepressed(x, y)
  signal.emit('shoot', x, y)
end

function love.update(dt)
  if dt > 0.04 then return end
  bullets:update(dt)
  enemies:update(dt)
  gun:update(dt)
  planets:update(dt)
  stars:update(dt)
  sun:update(dt)
end
