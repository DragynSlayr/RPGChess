local King = {}

function King.newKing(row, column, team)
  local king = Piece.newPiece(row, column, team)
  
  king.max_health = 250
  king.health = king.max_health
  king.damage = 300
  
  king.sprite = Sprite.load("pieces/king.tga", 100, 126)
  king.type = "King"
  
  function king:getMoves()
    for row = 1, Constants.NUM_ROWS do
      for col = 1, Constants.NUM_COLUMNS do
        local move = {}
        
        move.row = col
        move.column = row
        
        local dist = MathHelper.getDistanceBetween(self, move)
        
        if (dist == 1 or dist == math.sqrt(2)) then
          if Board.getPieceAt(move.column, move.row) == nil then
            table.insert(self.moves, move)
          end
          table.insert(self.attacks, move)
        end
      end
    end
    
    self:filter()
  end
  
  return king
end

return King