local Bishop = {}

function Bishop.newBishop(row, column, team)
  local bishop = Piece.newPiece(row, column, team)
  
  bishop.max_health = 125
  bishop.health = bishop.max_health
  bishop.damage = 60
  
  bishop.sprite = Sprite.load("pieces/bishop.tga", 78, 126)
  bishop.type = "Bishop"
  
  function bishop:getMoves()
    for row = 1, Constants.NUM_ROWS do
      for col = 1, Constants.NUM_COLUMNS do
        local move = {}
        
        move.row = col
        move.column = row
        
        local x_len = math.abs(self.row - move.row)
        local y_len = math.abs(self.column - move.column)
        
        if (x_len == y_len) then
          if Board.getPieceAt(move.column, move.row) == nil then
            table.insert(self.moves, move)
          end
          table.insert(self.attacks, move)
        end
      end
    end
    
    self:filter(true)
  end
  
  return bishop
end

return Bishop