local Pawn = {}

function Pawn.newPawn(row, column, team)
  local pawn = Piece.newPiece(row, column, team)
  
  pawn.health = 100
  pawn.sprite = Sprite.load("pieces/pawn.tga", 101, 126)
  
  function pawn:getMoves()
    self.moves[#self.moves + 1] = {self.row + 1, self.column + 1}
  end
  
  return pawn
end

return Pawn