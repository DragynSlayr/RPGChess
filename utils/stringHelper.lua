local StringHelper = {}

function StringHelper.countSub(s1, s2)
    local n = 0
    for s in s1:gmatch(s2) do
      n = n + 1 
    end
    return n
end

function StringHelper.split(s, c)
end

return StringHelper