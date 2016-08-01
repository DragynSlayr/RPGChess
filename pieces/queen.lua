local Queen = {}

function Queen.newQueen(row, column, team)
  local queen = Piece.newPiece(row, column, team)
  
  queen.health = 100
  queen.damage = 100
  queen.sprite = Sprite.load("pieces/queen.tga", 62, 126)
  
  function queen:getMoves()
    for row = 1, Constants.NUM_ROWS do
      for col = 1, Constants.NUM_COLUMNS do
        local move = {}
        
        move.row = col
        move.column = row
        
        local x_len = math.abs(self.row - move.row)
        local y_len = math.abs(self.column - move.column)
        
        local row_same = self.row == move.row
        local col_same = self.column == move.column
        
        if (x_len == y_len or row_same or col_same) and Board.getPieceAt(move.column, move.row) == nil then
          table.insert(self.moves, move)
        end
      end
    end
  end
  
  return queen
end

return Queen