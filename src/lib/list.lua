return function(klass)
  local List = {}
  List.__index = List

  function List:draw()
    for item in pairs(self) do
      item:draw()
    end
  end

  function List:each(f)
    for item in pairs(self) do
      f(item)
    end
  end

  function List:insert(data)
    local item = klass(data)
    item.list  = self
    self[item] = true
    return item
  end

  function List:load(list)
    for _, data in ipairs(list) do
      self:insert(data)
    end
  end

  function List:remove(item)
    self[item] = nil
    return item
  end

  function List:update(dt)
    for item in pairs(self) do
      item:update(dt)
    end
  end

  return setmetatable({}, List)
end
