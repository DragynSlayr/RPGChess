local Rook = {}

function Rook.newRook(row, column, team)
  local rook = Piece.newPiece(row, column, team)
  
  rook.health = 100
  rook.damage = 100
  rook.sprite = Sprite.load("pieces/rook.tga", 72, 126)
  
  function rook:getMoves()
    for row = 1, Constants.NUM_ROWS do
      for col = 1, Constants.NUM_COLUMNS do
        local move = {}
        
        move.row = col
        move.column = row
        
        if (self.row == move.row or self.column == move.column) then
          if Board.getPieceAt(move.column, move.row) == nil then
            table.insert(self.moves, move)
          end
          table.insert(self.attacks, move)
        end
      end
    end
  end
  
  return rook
end

return Rook