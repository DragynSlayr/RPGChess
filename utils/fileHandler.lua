local FileHandler = {}
  
function FileHandler.exists(name)
  local file = io.open("data/" .. name, "r")
  
  if file then
    file:close()
    return true
  else
    return false
  end
end

function FileHandler.read(name)
  if FileHandler.exists(name) then
    local file = io.open("data/" .. name, "r")
    local contents = file:read("*all")
    file:close()
    return contents
  else 
    return nil
  end
end

function FileHandler.write(name, data)
  local file = io.open("data/" .. name, "w")
  file:write(tostring(data))
  file:close()
end

return FileHandler