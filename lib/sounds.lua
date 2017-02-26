local signal = require('vendor.signal')

local bomber = love.audio.newSource('assets/bomber.wav', 'static')
local planet = love.audio.newSource('assets/planet.mp3', 'static')
local laser  = love.audio.newSource('assets/laser.wav',  'static')
local space  = love.audio.newSource('assets/space.mp3',  'stream')

space:setLooping(true)
space:setVolume(0.5)

signal.register('bomber:die', function()
  bomber:rewind()
  bomber:play()
end)

signal.register('planet:die', function()
  planet:rewind()
  planet:play()
end)

signal.register('shoot', function()
  laser:rewind()
  laser:play()
end)

signal.register('start', function()
  space:play()
end)
