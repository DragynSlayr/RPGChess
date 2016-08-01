local Piece = {}

Bishop = require("pieces.bishop")
King = require("pieces.king")
Knight = require("pieces.knight")
Pawn = require("pieces.pawn")
Queen = require("pieces.queen")
Rook = require("pieces.rook")

function Piece.newPiece(row, column, team)
  local piece = {}
  piece.moves = {}
  
  piece.row = column
  piece.column = row
  
  piece.team = team
  piece.active = false
  piece.moves_made = 0
  
  piece.forward_x = 1
  
  if piece.team == 2 then 
    piece.forward_x = -1
  end
  
  if piece.team == 1 then 
    piece.color = Board.player_one_color
  else 
    piece.color = Board.player_two_color
  end
  
  function piece:update(dt)
    self.x = Constants.BOARD_ORIGIN_X + ((self.row - 1) * (Constants.CELL_WIDTH + Constants.BORDER_SIZE)) + (Constants.CELL_WIDTH / 2)
    self.y = Constants.BOARD_ORIGIN_Y + ((self.column - 1) * (Constants.CELL_HEIGHT + Constants.BORDER_SIZE)) + (Constants.CELL_HEIGHT / 2)
  end
  
  function piece:draw()
    local r, g, b, a = love.graphics.getColor()
    
    if self.active then
      love.graphics.setColor(0, 255, 0, 100)
    else
      love.graphics.setColor(self.color[1], self.color[2], self.color[3], 100)
    end
    
    love.graphics.rectangle("fill", self.x - (Constants.CELL_WIDTH / 2), self.y - (Constants.CELL_HEIGHT / 2), Constants.CELL_WIDTH, Constants.CELL_HEIGHT)
    love.graphics.setColor(255, 255, 255, 127)
    
    Sprite.draw(self.sprite, self.x, self.y)
    
    love.graphics.setColor(255, 255, 255, 127)
    if self.active then
      for k, move in pairs(self.moves) do
        local x = Constants.BOARD_ORIGIN_X + ((move.row - 1) * (Constants.CELL_WIDTH + Constants.BORDER_SIZE))
        local y = Constants.BOARD_ORIGIN_Y + ((move.column - 1) * (Constants.CELL_HEIGHT + Constants.BORDER_SIZE))
        love.graphics.rectangle("fill", x, y, Constants.CELL_WIDTH, Constants.CELL_HEIGHT)
      end
    end
    
    love.graphics.setColor(r, g, b, a)
  end
  
  function piece:onClick(player)
    if player == self.team then
      self.active = not self.active
    end
    
    for k, p in pairs(Board.pieces) do 
      if p ~= self then
        p.active = false
        p.moves = {}
      end
    end
    
    if self.active then
      self:getMoves()
    else
      self.moves = {}
    end
  end
  
  return piece
end

return Piece