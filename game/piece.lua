local Piece = {}

Piece.health_modifier = 1
Piece.damage_modifier = 1

PieceHelper = require("utils.pieceHelper")
Bishop = require("pieces.bishop")
King = require("pieces.king")
Knight = require("pieces.knight")
Pawn = require("pieces.pawn")
Queen = require("pieces.queen")
Rook = require("pieces.rook")

Piece.available_sprite = Sprite.load("background/available.tga", 126, 126)
Piece.available_sprite:setAnimation(0)
Piece.available_sprite:setRotation(math.pi / 180)

Piece.selected_sprite = Sprite.load("background/selected.tga", 126, 126)
Piece.selected_sprite:setAnimation(0.5)
Piece.selected_sprite:setRotation(math.pi / 120)

Piece.health_sprite = Sprite.load("background/health.tga", 126, 126)
Piece.health_sprite:setAnimation(0)
Piece.health_sprite:setRotation(math.pi / 180)

Piece.move_sprite = Sprite.load("background/move.tga", 32, 32)
Piece.move_sprite:setAnimation(0)
Piece.move_sprite:setRotation(-math.pi / 120)

Piece.font = love.graphics.newFont("assets/fonts/op.ttf", 20)

Piece.red_death_x = 0
Piece.red_death_y = 0

Piece.blue_death_x = 0
Piece.blue_death_y = 0

Piece.red_dead = 0
Piece.blue_dead = 0

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
      self.x = self.death_x
      self.y = self.death_y
      
      for k, piece in pairs(Board.pieces) do
        if self == piece then
          table.remove(Board.pieces, k)
          table.insert(Board.graveyard, piece)
        end
      end
    end
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
      self:populateMoveSet()
    else
      self.moves = {}
    end
  end
  
  function piece:populateMoveSet()
    self:getMoves()
    self:getAttacks()
  end
  
  function piece:getMoveLine(x, y)
    local i = 1
    
    while true do
      local move = {}
      
      move.row = self.row + (i * (self.forward_x * y))
      move.column = self.column - (i * x)
      
      if PieceHelper.movePossible(move) then
        self.moves[#self.moves + 1] = move
        i = i + 1
      else 
        break
      end
    end
  end
  
  function piece:getAttackLine(x, y)
    local i = 1
    
    while true do
      local attack = {}
      
      attack.row = self.row + (i * (self.forward_x * y))
      attack.column = self.column - (i * x)
      
      if PieceHelper.attackPossible(self, attack) then
        self.attacks[#self.attacks + 1] = attack
        break
      else
        if PieceHelper.movePossible(attack) then
          i = i + 1
        else
          break
        end
      end
    end
  end
  
  function piece:endMove()
    self.active = false
    self.moves = {}
    self.attacks = {}
    self.moves_made = self.moves_made + 1
  end
  
  function piece:onDeath()
    if self.team == 1 then
      self.death_x = Constants.RED_GRAVE_X + Piece.red_death_x
      self.death_y = Constants.RED_GRAVE_Y + Piece.red_death_y
      
      local inc = Constants.GRAVE_X_INCREMENT
      if Piece.red_dead % 2 == 0 then
        inc = -Constants.GRAVE_X_INCREMENT
      end
      
      Piece.red_death_x = Piece.red_death_x + inc
      Piece.red_death_y = Piece.red_death_y + Constants.GRAVE_Y_INCREMENT
      
      Piece.red_dead = Piece.red_dead + 1
    else
      self.death_x = Constants.BLUE_GRAVE_X + Piece.blue_death_x
      self.death_y = Constants.BLUE_GRAVE_Y + Piece.blue_death_y
      
      local inc = Constants.GRAVE_X_INCREMENT
      if Piece.blue_dead % 2 == 1 then
        inc = -Constants.GRAVE_X_INCREMENT
      end
      
      Piece.blue_death_x = Piece.blue_death_x + inc
      Piece.blue_death_y = Piece.blue_death_y + Constants.GRAVE_Y_INCREMENT
      
      Piece.blue_dead = Piece.blue_dead + 1
    end
  end
  
  setmetatable(piece, {__tostring = function(t) return string.format("R: %d, C: %d, T: %d, P: %s", t.column, t.row, t.team, t.type) end})
  
  return piece
end

function Piece.drawMoves()
  for k, piece in pairs(Board.pieces) do
    if piece.active then
      local r, g, b, a = love.graphics.getColor()
      love.graphics.setColor(piece.color[1], 255, piece.color[3], 255)
      
      for k2, move in pairs(piece.moves) do
        local x = Constants.BOARD_ORIGIN_X + ((move.row - 1) * (Constants.CELL_WIDTH + Constants.BORDER_SIZE)) + (Constants.CELL_WIDTH / 2)
        local y = Constants.BOARD_ORIGIN_Y + ((move.column - 1) * (Constants.CELL_HEIGHT + Constants.BORDER_SIZE)) + (Constants.CELL_HEIGHT / 2)
        
        Sprite.draw(Piece.move_sprite, x, y)
      end
      
      love.graphics.setColor(r, g, b, a)
    end
  end
end

function Piece.drawAttacks()
  for k, piece in pairs(Board.pieces) do
    if piece.active then
      local r, g, b, a = love.graphics.getColor()
      love.graphics.setColor(piece.color[1], 127, piece.color[3], 255)
      
      for k2, attack in pairs(piece.attacks) do
        local x = Constants.BOARD_ORIGIN_X + ((attack.row - 1) * (Constants.CELL_WIDTH + Constants.BORDER_SIZE)) + (Constants.CELL_WIDTH / 2)
        local y = Constants.BOARD_ORIGIN_Y + ((attack.column - 1) * (Constants.CELL_HEIGHT + Constants.BORDER_SIZE)) + (Constants.CELL_HEIGHT / 2)
        
        Sprite.draw(Piece.selected_sprite, x, y)
      end
      
      love.graphics.setColor(r, g, b, a)
    end
  end
end

function Piece.drawBG()
  local r, g, b, a = love.graphics.getColor()
  
  for k, piece in pairs(Board.pieces) do
    if piece.active then 
      love.graphics.setColor(255, 255, 0, 255)
      Sprite.draw(Piece.selected_sprite, piece.x, piece.y)
    elseif (Board.current_player == piece.team) then
      love.graphics.setColor(piece.color[1], 255, piece.color[3], 255)
      Sprite.draw(Piece.available_sprite, piece.x, piece.y)
    end
  end
  
  love.graphics.setColor(r, g, b, a)
end

function Piece.drawSprite()
  local r, g, b, a = love.graphics.getColor()
    
    for k, piece in pairs(Board.pieces) do
      love.graphics.setColor(piece.color[1], 127, piece.color[3], 255)
      Sprite.draw(piece.sprite, piece.x, piece.y)
    end
    
    for k, piece in pairs(Board.graveyard) do
      love.graphics.setColor(255, 255, 255, 255)
      Sprite.draw(piece.sprite, piece.x, piece.y)
    end
    
  love.graphics.setColor(r, g, b, a)
end

function Piece.drawHealth()
    local r, g, b, a = love.graphics.getColor()
    local font = love.graphics.getFont()
    love.graphics.setFont(Piece.font)
    
    for k, piece in pairs(Board.pieces) do
      love.graphics.setColor(0, 255, 0, 255)
      Sprite.draw(Piece.health_sprite, piece.x, piece.y)
      
      local health = math.abs(piece.health / piece.max_health)
      health = math.min(health, 1)
      
      love.graphics.setColor(piece.color[1], piece.color[2], piece.color[3], 255)
      love.graphics.circle("fill", piece.x, piece.y, ((126 / 2) - 7) * (1 - health), 100)
    end
    
  love.graphics.setColor(r, g, b, a)
  love.graphics.setFont(font)
end

function Piece.resetAll()
  for k, piece in pairs(Board.pieces) do
    if (piece.active) then
      piece.active = false
      piece.moves = {}
      piece.attacks = {}
    end
  end
end

return Piece