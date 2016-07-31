local Knight = {}

function Knight.newKnight(row, column, team)
  local knight = Piece.newPiece(row, column, team)
  
  knight.health = 100
  knight.sprite = Sprite.load("pieces/knight.tga", 72, 126)
  
  function knight:getMoves()
    for row = 1, Constants.NUM_ROWS do
      for col = 1, Constants.NUM_COLUMNS do
        local move = {}
        
        move.row = col
        move.column = row
        
        if MathHelper.getDistanceBetween(self, move) == math.sqrt(5) then
          table.insert(self.moves, move)
        end
      end
    end
  end
  
  return knight
end

return Knight