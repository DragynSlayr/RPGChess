local King = {}

function King.newKing(row, column, color, health, team)
  local king = Piece.newPiece(row, column, color)
  
  king.health = health
  king.team = team
  
  king.sprite = nil
  
  function king:update(dt)
    self.x = Constants.BOARD_ORIGIN_X + ((self.row - 1) * (Constants.CELL_WIDTH + Constants.BORDER_SIZE)) + (Constants.CELL_WIDTH / 2)
    self.y = Constants.BOARD_ORIGIN_Y + ((self.column - 1) * (Constants.CELL_HEIGHT + Constants.BORDER_SIZE)) + (Constants.CELL_HEIGHT / 2)
  end
  
  function king:draw()
    local r, g, b = love.graphics.getColor()
    
    love.graphics.setColor(self.color[1], self.color[2], self.color[3])
    
    love.graphics.print("K", self.x, self.y)
    
    love.graphics.setColor(r, g, b)
  end
  
  function king:onClick(player)
    if self.team == player then
    end
  end
  
  return king
end

return King