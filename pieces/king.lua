local King = {}

function King.newKing(row, column, team)
  local king = Piece.newPiece(row, column, team)
  
  king.max_health = 600 * Piece.health_modifier
  king.health = king.max_health
  king.damage = 600 * Piece.damage_modifier
  
  king.sprite = Sprite.load("pieces/king.tga", 100, 126)
  king.type = "King"
  
  function king:getMoves()
    for row = 1, Constants.NUM_ROWS do
      for col = 1, Constants.NUM_COLUMNS do
        local move = {}
        
        move.row = col
        move.column = row
        
        local dist = MathHelper.getDistanceBetween(self, move)
        
        if ((dist == math.sqrt(2)) or (dist == 1)) then
          if PieceHelper.movePossible(move) then
            self.moves[#self.moves + 1] = move
          end
        end
      end
    end
  end
  
  function king:getAttacks()
    for row = 1, Constants.NUM_ROWS do
      for col = 1, Constants.NUM_COLUMNS do
        local attack = {}
        
        attack.row = col
        attack.column = row
        
        local dist = MathHelper.getDistanceBetween(self, attack)
        
        if ((dist == math.sqrt(2)) or (dist == 1)) then
          if PieceHelper.attackPossible(self, attack) then
            self.attacks[#self.attacks + 1] = attack
          end
        end
      end
    end
  end
  
  return king
end

return King