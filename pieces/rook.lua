local Rook = {}

function Rook.newRook(row, column, team)
  local rook = Piece.newPiece(row, column, team)
  
  rook.health = 100
  rook.sprite = Sprite.load("pieces/rook.tga", 72, 126)
  
  function rook:getMoves()
    self.moves[#self.moves + 1] = {self.row + 1, self.column + 1}
  end
  
  return rook
end

return Rook