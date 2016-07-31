local Knight = {}

function Knight.newKnight(row, column, team)
  local knight = Piece.newPiece(row, column, team)
  
  knight.health = 100
  knight.sprite = Sprite.load("pieces/knight.tga", 72, 126)
  
  function knight:getMoves()
    self.moves[#self.moves + 1] = {self.row + 1, self.column + 1}
  end
  
  return knight
end

return Knight