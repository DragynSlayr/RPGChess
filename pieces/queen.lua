local Queen = {}

function Queen.newQueen(row, column, team)
  local queen = Piece.newPiece(row, column, team)
  
  queen.max_health = 500
  queen.health = queen.max_health
  queen.damage = 500
  
  queen.sprite = Sprite.load("pieces/queen.tga", 62, 126)
  queen.type = "Queen"
  
  function queen:populateMoveSet()
    self:getMoveLine(1, 1)
    self:getMoveLine(1, -1)
    self:getMoveLine(-1, 1)
    self:getMoveLine(-1, -1)
    self:getMoveLine(1, 0)
    self:getMoveLine(-1, 0)
    self:getMoveLine(0, 1)
    self:getMoveLine(0, -1)
    
    self:getAttackLine(1, 0)
    self:getAttackLine(-1, 0)
    self:getAttackLine(0, 1)
    self:getAttackLine(0, -1)
    self:getAttackLine(1, 1)
    self:getAttackLine(1, -1)
    self:getAttackLine(-1, 1)
    self:getAttackLine(-1, -1)
  end
  
  return queen
end

return Queen