local Bishop = {}

function Bishop.newBishop(row, column, color, health, team)
  local bishop = Piece.newPiece(row, column, color)
  
  bishop.health = health
  bishop.team = team
  
  bishop.sprite = nil
  
  function bishop:update(dt)
    self.x = Constants.BOARD_ORIGIN_X + ((self.row - 1) * (Constants.CELL_WIDTH + Constants.BORDER_SIZE)) + (Constants.CELL_WIDTH / 2)
    self.y = Constants.BOARD_ORIGIN_Y + ((self.column - 1) * (Constants.CELL_HEIGHT + Constants.BORDER_SIZE)) + (Constants.CELL_HEIGHT / 2)
  end
  
  function bishop:draw()
    local r, g, b = love.graphics.getColor()
    
    love.graphics.setColor(self.color[1], self.color[2], self.color[3])
    
    love.graphics.print("B", self.x, self.y)
    
    love.graphics.setColor(r, g, b)
  end
  
  function bishop:onClick(player)
    if self.team == player then
    end
  end
  
  return bishop
end

return Bishop