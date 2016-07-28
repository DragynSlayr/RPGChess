local Rook = {}

function Rook.newRook(row, column, color, health, team)
  local rook = Piece.newPiece(row, column, color)
  
  rook.health = health
  rook.team = team
  
  rook.sprite = nil
  
  function rook:update(dt)
    self.x = Constants.BOARD_ORIGIN_X + ((self.row - 1) * (Constants.CELL_WIDTH + Constants.BORDER_SIZE)) + (Constants.CELL_WIDTH / 2)
    self.y = Constants.BOARD_ORIGIN_Y + ((self.column - 1) * (Constants.CELL_HEIGHT + Constants.BORDER_SIZE)) + (Constants.CELL_HEIGHT / 2)
  end
  
  function rook:draw()
    local r, g, b = love.graphics.getColor()
    
    love.graphics.setColor(self.color[1], self.color[2], self.color[3])
    
    love.graphics.print("R", self.x, self.y)
    
    love.graphics.setColor(r, g, b)
  end
  
  function rook:onClick(player)
    if self.team == player then
    end
  end
  
  return rook
end

return Rook