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
  piece.attacks = {}
  
  piece.row = column
  piece.column = row
  
  piece.team = team
  piece.active = false
  piece.alive = true
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
    if self.alive then
      self.x = Constants.BOARD_ORIGIN_X + ((self.row - 1) * (Constants.CELL_WIDTH + Constants.BORDER_SIZE)) + (Constants.CELL_WIDTH / 2)
      self.y = Constants.BOARD_ORIGIN_Y + ((self.column - 1) * (Constants.CELL_HEIGHT + Constants.BORDER_SIZE)) + (Constants.CELL_HEIGHT / 2)
      
      if self.health <= 0 then
        self.alive = false
      end
    else
      for k, piece in pairs(Board.pieces) do
        if self == piece then
          table.remove(Board.pieces, k)
        end
      end
    end
  end
  
  function piece:draw()
    local r, g, b, a = love.graphics.getColor()
    
    if self.active then
      love.graphics.setColor(0, 255, 0, 100)
    else
      love.graphics.setColor(self.color[1], self.color[2], self.color[3], 50)
    end
    
    love.graphics.rectangle("fill", self.x - (Constants.CELL_WIDTH / 2), self.y + (Constants.CELL_HEIGHT / 2), Constants.CELL_WIDTH, -Constants.CELL_HEIGHT / (self.max_health / self.health))
    
    --love.graphics.setColor(r, g, b, 255)
    love.graphics.setColor(self.color[1], 127, self.color[3], 255)
    Sprite.draw(self.sprite, self.x, self.y)
    
    if self.active then
      love.graphics.setColor(self.color[1], self.color[2], self.color[3], 100)
      
      for k, move in pairs(self.moves) do
        local x = Constants.BOARD_ORIGIN_X + ((move.row - 1) * (Constants.CELL_WIDTH + Constants.BORDER_SIZE))
        local y = Constants.BOARD_ORIGIN_Y + ((move.column - 1) * (Constants.CELL_HEIGHT + Constants.BORDER_SIZE))
        love.graphics.rectangle("fill", x, y, Constants.CELL_WIDTH, Constants.CELL_HEIGHT)
      end
      
      for k, attack in pairs(self.attacks) do
        local x = Constants.BOARD_ORIGIN_X + ((attack.row - 1) * (Constants.CELL_WIDTH + Constants.BORDER_SIZE))
        local y = Constants.BOARD_ORIGIN_Y + ((attack.column - 1) * (Constants.CELL_HEIGHT + Constants.BORDER_SIZE))
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
  
  function piece:filter(advanced)
    for i = 1, #self.moves do
      local move = self.moves[i]
      if Board.getPieceAt(move.column, move.row) then
        self.moves[i] = nil
      end
    end
    
    for i = 1, #self.attacks do
      local attack = self.attacks[i]
      if Board.getPieceAt(attack.column, attack.row) ~= nil then
        local p = Board.getPieceAt(attack.column, attack.row)
        if p.team == self.team then
          self.attacks[i] = nil
        end
      else
        self.attacks[i] = nil
      end
    end
    
    if advanced then
      --[[
      for i = 1, #self.moves do
        local move = self.moves[i]
        for j = 1, #Board.pieces do
          local piece = Board.pieces[j]
          if piece and move and piece ~= self then
            if MathHelper.blockingLine(self, move, piece) then
              self.moves[i] = nil
              break
            end
          end
        end
      end
      ]]--
      
      --[[
      for i = 1, #self.attacks do
        local attack = self.attacks[i]
        for j = 1, #Board.pieces do
          local piece = Board.pieces[j]
          if piece ~= self then
            if piece and attack then
                if MathHelper.blockingLine(self, attack, piece) then
                  self.attacks[i] = nil
                end
            end
          end
        end
      end
      ]]--
    end
  end
  
  setmetatable(piece, {__tostring = function(t) return string.format("R: %d, C: %d, T: %d, P: %s", t.column, t.row, t.team, t.type) end})
  
  return piece
end

return Piece