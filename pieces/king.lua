local King = {}

function King.newKing(row, column, team)
  local king = Piece.newPiece(row, column, team)
  
  king.health = 100
  king.sprite = Sprite.load("pieces/king.tga", 100, 126)
  
  function king:getMoves()
    for row = 1, Constants.NUM_ROWS do
      for col = 1, Constants.NUM_COLUMNS do
        local move = {}
        
        move.row = col
        move.column = row
        
        local dist = MathHelper.getDistanceBetween(self, move)
        
        if dist == 1 or dist == math.sqrt(2) then
          table.insert(self.moves, move)
        end
      end
    end
  end
  
  return king
end

return King