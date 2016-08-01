local Pawn = {}

function Pawn.newPawn(row, column, team)
  local pawn = Piece.newPiece(row, column, team)
  
  pawn.health = 100
  pawn.damage = 100
  pawn.sprite = Sprite.load("pieces/pawn.tga", 101, 126)
  
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
  end
  
  return pawn
end

return Pawn