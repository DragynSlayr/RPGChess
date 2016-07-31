local Bishop = {}

function Bishop.newBishop(row, column, team)
  local bishop = Piece.newPiece(row, column, team)
  
  bishop.health = 100
  bishop.sprite = Sprite.load("pieces/bishop.tga", 78, 126)
  
  function bishop:getMoves()
    self.moves[#self.moves + 1] = {self.row + 1, self.column + 1}
  end
  
  return bishop
end

return Bishop