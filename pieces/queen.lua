local Queen = {}

function Queen.newQueen(row, column, team)
  local queen = Piece.newPiece(row, column, team)
  
  queen.health = 100
  queen.sprite = Sprite.load("pieces/queen.tga", 62, 126)
  
  function queen:getMoves()
    self.moves[#self.moves + 1] = {self.row + 1, self.column + 1}
  end
  
  return queen
end

return Queen