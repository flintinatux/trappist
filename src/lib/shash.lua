local Shash  = require('vendor.shash')

local sh = Shash.new()

return {
  add = function(obj)
    sh:add(obj, obj:bbox())
  end,

  each   = bind(sh.each,   sh),
  remove = bind(sh.remove, sh),

  update =function(obj)
    sh:update(obj, obj:bbox())
  end
}
