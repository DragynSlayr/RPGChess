local MathHelper = {}

function MathHelper.load()
  math.randomseed(os.time())
  math.random(); math.random(); math.random()
end

function MathHelper.getDistanceBetween(a, b)
  local x_dist = a.column - b.column
  local y_dist = a.row - b.row
  
  x_dist = x_dist * x_dist
  y_dist = y_dist * y_dist
  
  return math.sqrt(x_dist + y_dist)
end

function MathHelper.random(lower, upper)
  if upper then
    return math.random(lower, upper)
  else
    return math.random(lower)
  end
end

MathHelper.load()

return MathHelper