local Bishop = {}

function Bishop.newBishop(row, column, team)
  local bishop = Piece.newPiece(row, column, team)
  
  bishop.health = 100
  bishop.sprite = Sprite.load("pieces/bishop.tga", 78, 126)
  
  function bishop:getMoves()
    for row = 1, Constants.NUM_ROWS do
      for col = 1, Constants.NUM_COLUMNS do
        local move = {}
        
        move.row = col
        move.column = row
        
        local x_len = math.abs(self.row - move.row)
        local y_len = math.abs(self.column - move.column)
        
        if x_len == y_len then
          table.insert(self.moves, move)
        end
      end
    end
  end
  
  return bishop
end

return Bishop