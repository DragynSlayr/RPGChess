local King = {}

function King.newKing(row, column, team)
  local king = Piece.newPiece(row, column, team)
  
  king.health = 100
  king.sprite = Sprite.load("pieces/king.tga", 100, 126)
  
  function king:getMoves()
    self.moves[#self.moves + 1] = {self.row + 1, self.column + 1}
  end
  
  return king
end

return King