local Knight = {}

function Knight.newKnight(row, column, team)
  local knight = Piece.newPiece(row, column, team)
  
  knight.health = 100
  knight.damage = 100
  knight.sprite = Sprite.load("pieces/knight.tga", 72, 126)
  knight.type = "Knight"
  
  function knight:getMoves()
    for row = 1, Constants.NUM_ROWS do
      for col = 1, Constants.NUM_COLUMNS do
        local move = {}
        
        move.row = col
        move.column = row
        
        if MathHelper.getDistanceBetween(self, move) == math.sqrt(5) then
          if Board.getPieceAt(move.column, move.row) == nil then
            table.insert(self.moves, move)
          end
          table.insert(self.attacks, move)
        end
      end
    end
    self:filter()
  end
  
  return knight
end

return Knight