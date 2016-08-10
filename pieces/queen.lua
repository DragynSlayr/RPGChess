local Queen = {}

function Queen.newQueen(row, column, team)
  local queen = Piece.newPiece(row, column, team)
  
  queen.max_health = 190
  queen.health = queen.max_health
  queen.damage = 130
  
  queen.sprite = Sprite.load("pieces/queen.tga", 62, 126)
  queen.type = "Queen"
  
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
        
        setmetatable(move, {__tostring = function(t) return string.format("R: %d, C: %d", t.column, t.row) end})
        
        if (x_len == y_len or row_same or col_same) then
          if Board.getPieceAt(move.column, move.row) == nil then
            table.insert(self.moves, move)
          end
          table.insert(self.attacks, move)
        end
      end
    end
    
    self:filter(true)
  end
  
  return queen
end

return Queen