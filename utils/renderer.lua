local Renderer = {}

local num_layers = 10

function Renderer.reset()
  Renderer.layers = {}
  
  for i = 1, num_layers do
    Renderer.layers[i] = {}
  end
end

function Renderer.add(f, layer)
  Renderer.layers[layer][#Renderer.layers[layer] + 1] = f
end

function Renderer.render()
  for i = 1, num_layers do
    for j = 1, #Renderer.layers[i] do
      Renderer.layers[i][j]()
    end
  end
  
  Renderer.reset()
end

Renderer.reset()

return Renderer