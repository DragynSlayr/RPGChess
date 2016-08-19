local Knight = {}

function Knight.newKnight(row, column, team)
  local knight = Piece.newPiece(row, column, team)
  
  knight.max_health = 200
  knight.health = knight.max_health
  knight.damage = 200
  
  knight.sprite = Sprite.load("pieces/knight.tga", 72, 126)
  knight.type = "Knight"
  
  function knight:getMoves()
    for row = 1, Constants.NUM_ROWS do
      for col = 1, Constants.NUM_COLUMNS do
        local move = {}
        
        move.row = col
        move.column = row
        
        if MathHelper.getDistanceBetween(self, move) == math.sqrt(5) then
          if PieceHelper.movePossible(move) then
            self.moves[#self.moves + 1] = move
          end
        end
      end
    end
  end
  
  function knight:getAttacks()
    for row = 1, Constants.NUM_ROWS do
      for col = 1, Constants.NUM_COLUMNS do
        local attack = {}
        
        attack.row = col
        attack.column = row
        
        if MathHelper.getDistanceBetween(self, attack) == math.sqrt(5) then
          if PieceHelper.attackPossible(self, attack) then
            self.attacks[#self.attacks + 1] = attack
          end
        end
      end
    end
  end
  
  return knight
end

return Knight