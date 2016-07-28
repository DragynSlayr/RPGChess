local Sprite = {}

function Sprite.load(path, width, height)
  local sprite = {}
  
  sprite.image = love.graphics.newImage("assets/sprites/" .. path)
  
  sprite.frames = sprite.image:getWidth() / width
  
  sprite.height = height
  sprite.width = width
  
  sprite.x_scale = 1.0
  sprite.y_scale = 1.0
  
  sprite.scaled_width = sprite.width * sprite.x_scale
  sprite.scaled_height = sprite.height * sprite.y_scale
  
  sprite.animated = false
  
  sprite.sprites = {}
  
  for i = 0, sprite.frames - 1 do
    sprite.sprites[i + 1] = love.graphics.newQuad(i  * sprite.width, 0, sprite.width, sprite.height, sprite.image:getDimensions())
  end
  
  function sprite:setScale(x_scale, y_scale)
    self.x_scale = x_scale
    self.y_scale = y_scale
  end
  
  function sprite:setAnimation(delay)
    self.animated = true
    self.time = 0
    self.max_time = delay / self.frames
    self.current_frame = 1
  end
  
  function sprite:update(dt)
    if self.animated then
      self.time = self.time + dt
      
      if self.time >= self.max_time then
        self.time = 0
        
        if self.current_frame == self.frames then
          self.current_frame = 1
        else 
          self.current_frame = self.current_frame + 1
        end
      end
    end
  end
  
  return sprite
end

function Sprite.draw(sprite, x, y)
  if sprite.animated then
    love.graphics.draw(sprite.image, sprite.sprites[sprite.current_frame], x, y, 0, sprite.x_scale, sprite.y_scale, sprite.width / 2, sprite.height / 2)
  else
    love.graphics.draw(sprite.image, sprite.sprites[1], x, y, 0, sprite.x_scale, sprite.y_scale, sprite.width / 2, sprite.height / 2)
  end
end

return Sprite