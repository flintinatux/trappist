require('lib.util').import()
math.randomseed(os.time())
require('vendor.autobatch')
require('lib.sounds')

local Game  = require('states.game')
local State = require('vendor.state')

love.mouse.setVisible(false)

function love.load()
  State.registerEvents()
  State.switch(Game)
end
