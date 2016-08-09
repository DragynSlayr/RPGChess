local Rook = {}

function Rook.newRook(row, column, team)
  local rook = Piece.newPiece(row, column, team)
  
  rook.max_health = 200
  rook.health = rook.max_health
  rook.damage = 75
  
  rook.sprite = Sprite.load("pieces/rook.tga", 72, 126)
  rook.type = "Rook"
  
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
    self:filter()
  end
  
  return rook
end

return Rook