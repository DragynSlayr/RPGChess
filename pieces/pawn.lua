local Pawn = {}

function Pawn.newPawn(row, column, team)
  local pawn = Piece.newPiece(row, column, team)
  
  pawn.max_health = 100 * Piece.health_modifier
  pawn.health = pawn.max_health
  pawn.damage = 100 * Piece.damage_modifier
  
  pawn.sprite = Sprite.load("pieces/pawn.tga", 101, 126)
  pawn.type = "Pawn"
  
  function pawn:getMoves()    
    local move = {}
    
    move.row = self.row + (1 * self.forward_x)
    move.column = self.column
    
    if PieceHelper.movePossible(move) then
      self.moves[#self.moves + 1] = move
      
      if self.moves_made == 0 then
        move = {}
        
        move.row = self.row + (2 * self.forward_x)
        move.column = self.column
        
        if PieceHelper.movePossible(move) then
          self.moves[#self.moves + 1] = move
        end
      end
    end
  end
  
  function pawn:getAttacks()
    local attack = {}
    local attacks = {}
    
    attack.row = self.row + (1 * self.forward_x)
    attack.column = self.column + 1
    
    attacks[#attacks + 1] = attack
    
    attack = {}
    attack.row = self.row + (1 * self.forward_x)
    attack.column = self.column - 1
    
    attacks[#attacks + 1] = attack
    
    for i = 1, #attacks do
      if PieceHelper.attackPossible(self, attacks[i]) then
        self.attacks[#self.attacks + 1] = attacks[i]
      end
    end
  end
  
  return pawn
end

return Pawn