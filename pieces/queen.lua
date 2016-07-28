local Queen = {}

function Queen.newQueen(row, column, color, health, team)
  local queen = Piece.newPiece(row, column, color)
  
  queen.health = health
  queen.team = team
  
  queen.sprite = nil
  
  function queen:update(dt)
    self.x = Constants.BOARD_ORIGIN_X + ((self.row - 1) * (Constants.CELL_WIDTH + Constants.BORDER_SIZE)) + (Constants.CELL_WIDTH / 2)
    self.y = Constants.BOARD_ORIGIN_Y + ((self.column - 1) * (Constants.CELL_HEIGHT + Constants.BORDER_SIZE)) + (Constants.CELL_HEIGHT / 2)
  end
  
  function queen:draw()
    local r, g, b = love.graphics.getColor()
    
    love.graphics.setColor(self.color[1], self.color[2], self.color[3])
    
    love.graphics.print("Q", self.x, self.y)
    
    love.graphics.setColor(r, g, b)
  end
  
  function queen:onClick(player)
    if self.team == player then
    end
  end
  
  return queen
end

return Queen