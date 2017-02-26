local Bullets = require('entities.bullets')
local debug   = require('entities.debug')
local defs    = require('lib.planet-defs')
local Ending  = require('states.ending')
local Enemies = require('entities.enemies')
local Gun     = require('entities.gun')
local List    = require('lib.list')
local Planet  = require('entities.planet')
local shaker  = require('entities.shaker')
local signal  = require('vendor.signal')
local Star    = require('entities.star')
local stats   = require('entities.stats')
local State   = require('vendor.state')
local Sun     = require('entities.sun')

love.mouse.setVisible(false)
local w, h = love.graphics.getDimensions()

local Game = {}

function Game:init()
  self.bullets = Bullets()
  self.debugging = false
  self.sun = Sun({ r = 10, x = w/2, y = h/2 })
  self.planets = List(compose(Planet, assoc('sun', self.sun)))
  self.planets:load(defs)
  self.enemies = Enemies({ planets = self.planets })
  self.gun = Gun({ planets = self.planets })

  self.stars = List(Star)
  for _ = 1, 400 do
    self.stars:insert({
      x = math.random() * w,
      y = math.random() * h
    })
  end
end

function Game:draw()
  shaker:draw()
  self.stars:draw()
  self.sun:draw()
  self.planets:draw()
  self.enemies:draw()
  self.bullets:draw()
  self.gun:draw()
  if self.debugging then debug:draw() else stats:draw() end
end

function Game:keypressed(key)
  if key == 'd' then
    self.debugging = not self.debugging
  end
end

function Game:enter()
  signal.emit('start')
end

function Game:leave()
  signal.emit('stop')
end

function Game:mousepressed(x, y)
  signal.emit('shoot', x, y)
end

function Game:update(dt)
  if dt > 0.04 then return end
  shaker:update(dt)
  self.gun:update(dt)
  self.bullets:update(dt)
  self.enemies:update(dt)
  self.planets:update(dt)
  self.stars:update(dt)
  self.sun:update(dt)
  stats:update(dt)

  if not next(self.planets) then State.switch(Ending) end
end

return Game
