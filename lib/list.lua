return function(class, init)
  init = init or {}
  local idx, list = {}, {}

  function list:draw()
    for i = #list, 1, -1 do
      list[i]:draw()
    end
  end

  function list:insert(item)
    item = class(item)
    idx[item] = #list+1
    list[#list+1] = item
  end

  function list:remove(item)
    table.remove(list, idx[item])
    idx[item] = nil
  end

  function list:update(dt)
    for i = #list, 1, -1 do
      list[i]:update(dt)
    end
  end

  for _, item in ipairs(init) do
    list:insert(item)
  end

  return list
end
