require('lib.util').import()
math.randomseed(os.time())
require('vendor.autobatch')
require('lib.sounds')

local bullets = require('entities.bullets')()
local debug   = require('entities.debug')
local defs    = require('lib.planet-defs')
local Enemies = require('entities.enemies')
local Gun     = require('entities.gun')
local List    = require('lib.list')
local Planet  = require('entities.planet')
local shaker  = require('entities.shaker')
local signal  = require('vendor.signal')
local Star    = require('entities.star')
local stats   = require('entities.stats')()
local Sun     = require('entities.sun')

love.mouse.setVisible(false)

local w, h = love.graphics.getDimensions()

local debugging = false
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
  shaker:draw()
  stars:draw()
  sun:draw()
  planets:draw()
  enemies:draw()
  bullets:draw()
  gun:draw()
  if debugging then debug:draw() else stats:draw() end
end

function love.keypressed(key)
  if key == 'd' then
    debugging = not debugging
  end
end

function love.load()
  signal.emit('start')
end

function love.mousepressed(x, y)
  signal.emit('shoot', x, y)
end

function love.update(dt)
  if dt > 0.04 then return end
  shaker:update(dt)
  bullets:update(dt)
  enemies:update(dt)
  gun:update(dt)
  planets:update(dt)
  stars:update(dt)
  sun:update(dt)
  stats:update(dt)
end
