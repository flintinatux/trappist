require('lib.util').import()

local defs   = require('lib.planet-defs')
local Gun    = require('entities.gun')
local Planet = require('entities.planet')
local Sun    = require('entities.sun')

love.mouse.setVisible(false)

local w, h = love.graphics.getDimensions()

local sun = Sun({
  r = 10,
  x = w/2,
  y = h/2
})

local planets = map(compose(Planet, assoc('sun', sun)), defs)
local gun     = Gun({ planets = planets })

function love.update(dt)
  if dt > 0.04 then return end
  sun:update(dt)
  for _, planet in ipairs(planets) do
    planet:update(dt)
  end
  gun:update(dt)
end

function love.draw()
  sun:draw()
  for _, planet in ipairs(planets) do
    planet:draw()
  end
  gun:draw()
end
