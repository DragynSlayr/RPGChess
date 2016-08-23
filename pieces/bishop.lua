local Bishop = {}

function Bishop.newBishop(row, column, team)
  local bishop = Piece.newPiece(row, column, team)
  
  bishop.max_health = 300 * Piece.health_modifier
  bishop.health = bishop.max_health
  bishop.damage = 300 * Piece.damage_modifier
  
  bishop.sprite = Sprite.load("pieces/bishop.tga", 78, 126)
  bishop.type = "Bishop"
  
  function bishop:populateMoveSet()
    self:getMoveLine(1, 1)
    self:getMoveLine(1, -1)
    self:getMoveLine(-1, 1)
    self:getMoveLine(-1, -1)
    
    self:getAttackLine(1, 1)
    self:getAttackLine(1, -1)
    self:getAttackLine(-1, 1)
    self:getAttackLine(-1, -1)
  end
  
  return bishop
end

return Bishop