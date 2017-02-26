local Bullet = require('entities.bullet')
local List   = require('lib.list')
local signal = require('vendor.signal')

return function()
  local bullets = List(Bullet)

  signal.register('bullet', bind(bullets.insert, bullets))

  return bullets
end
