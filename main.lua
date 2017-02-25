require('lib.util').import()

local defs   = require('lib.planet-defs')
local Planet = require('entities.planet')
local Sun    = require('entities.sun')

local w, h = love.graphics.getDimensions()

local sun = Sun({
  r = 10,
  x = w/2,
  y = h/2
})

local planets = map(compose(Planet, assoc('sun', sun)), defs)

function love.update(dt)
  sun:update(dt)
  for _, planet in ipairs(planets) do
    planet:update(dt)
  end
end

function love.draw()
  sun:draw()
  for _, planet in ipairs(planets) do
    planet:draw()
  end
end
