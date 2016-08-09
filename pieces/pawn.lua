local Pawn = {}

function Pawn.newPawn(row, column, team)
  local pawn = Piece.newPiece(row, column, team)
  
  pawn.max_health = 100
  pawn.health = pawn.max_health
  pawn.damage = 25
  
  pawn.sprite = Sprite.load("pieces/pawn.tga", 101, 126)
  pawn.type = "Pawn"
  
  function pawn:getMoves()    
    local move = {}
    move.row = self.row + (1 * self.forward_x)
    move.column = self.column
    
    if Board.getPieceAt(move.column, move.row) == nil then
      table.insert(self.moves, move)
      
      if self.moves_made == 0 then
        local move = {}
        move.row = self.row + (2 * self.forward_x)
        move.column = self.column
        
        table.insert(self.moves, move)
      end
    end
    
    local attack = {}
    attack.row = self.row + (1 * self.forward_x)
    attack.column = self.column - 1
    
    table.insert(self.attacks, attack)
    
    attack = {}
    attack.row = self.row + (1 * self.forward_x)
    attack.column = self.column + 1
    
    table.insert(self.attacks, attack)
    
    self:filter()
  end
  
  return pawn
end

return Pawn