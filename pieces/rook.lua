local Rook = {}

function Rook.newRook(row, column, team)
  local rook = Piece.newPiece(row, column, team)
  
  rook.max_health = 400
  rook.health = rook.max_health
  rook.damage = 400
  
  rook.sprite = Sprite.load("pieces/rook.tga", 72, 126)
  rook.type = "Rook"
  
  function rook:populateMoveSet()
    self:getMoveLine(1, 0)
    self:getMoveLine(-1, 0)
    self:getMoveLine(0, 1)
    self:getMoveLine(0, -1)
    
    self:getAttackLine(1, 0)
    self:getAttackLine(-1, 0)
    self:getAttackLine(0, 1)
    self:getAttackLine(0, -1)
  end
  
  return rook
end

return Rook