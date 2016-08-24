local Board = {}
Piece = require("game.piece")

function Board.load()
  Board.sprite = Sprite.load("background/board.tga", 1080, 1080)
  Board.side = Sprite.load("background/side.tga", 420, 1080)
  
  Board.player_one_color = {255, 0, 0}
  Board.player_two_color = {0, 0, 255}
  
  Board.pieces = {}
  Board.fill()
  
  Board.graveyard = {}
end

function Board.fill()
  for col = 2, 7, 5 do
    for row = 1, Constants.NUM_ROWS do
      if col == 2 then
        Board.pieces[#Board.pieces + 1] = Pawn.newPawn(row, col, 1)
      else 
        Board.pieces[#Board.pieces + 1] = Pawn.newPawn(row, col, 2)
      end
    end
  end
  
  Board.pieces[#Board.pieces + 1] = Rook.newRook(1, 1, 1)
  Board.pieces[#Board.pieces + 1] = Rook.newRook(8, 1, 1)
  Board.pieces[#Board.pieces + 1] = Rook.newRook(1, 8, 2)
  Board.pieces[#Board.pieces + 1] = Rook.newRook(8, 8, 2)
  
  Board.pieces[#Board.pieces + 1] = Knight.newKnight(2, 1, 1)
  Board.pieces[#Board.pieces + 1] = Knight.newKnight(7, 1, 1)
  Board.pieces[#Board.pieces + 1] = Knight.newKnight(2, 8, 2)
  Board.pieces[#Board.pieces + 1] = Knight.newKnight(7, 8, 2)
  
  Board.pieces[#Board.pieces + 1] = Bishop.newBishop(3, 1, 1)
  Board.pieces[#Board.pieces + 1] = Bishop.newBishop(6, 1, 1)
  Board.pieces[#Board.pieces + 1] = Bishop.newBishop(3, 8, 2)
  Board.pieces[#Board.pieces + 1] = Bishop.newBishop(6, 8, 2)
  
  Board.pieces[#Board.pieces + 1] = Queen.newQueen(4, 1, 1)
  Board.pieces[#Board.pieces + 1] = Queen.newQueen(4, 8, 2)
  
  Board.pieces[#Board.pieces + 1] = King.newKing(5, 1, 1)
  Board.pieces[#Board.pieces + 1] = King.newKing(5, 8, 2)
end

function Board.getLocation(x, y)
  x, y = x - Constants.BOARD_ORIGIN_X, y - Constants.BOARD_ORIGIN_Y
  
  local x_valid = x >= 0 and x <= Constants.BOARD_WIDTH - (2 * Constants.BORDER_SIZE)
  local y_valid = y >= 0 and y <= Constants.BOARD_HEIGHT - (2 * Constants.BORDER_SIZE)
  
  if (x_valid and y_valid) then
    local row = math.ceil(y / (Constants.CELL_HEIGHT + Constants.BORDER_SIZE))
    local column = math.ceil(x / (Constants.CELL_WIDTH + Constants.BORDER_SIZE))

    return row, column
  end
end

function Board.checkClick(row, col)
  if Board.getPieceAt(row, col) ~= nil then
    Board.handleAttack(row, col)
  else
    Board.handleMovement(row, col)
  end
end

function Board.handleAttack(row, col)
  if Board.getActiveCount() == 0 then
    local piece = Board.getPieceAt(row, col)
    
    if not piece.active then
      piece:onClick(Board.current_player)
    end
  else
    for k, piece in pairs(Board.pieces) do
      for k2, attack in pairs(piece.attacks) do
        if attack.row == col and attack.column == row and Board.getPieceAt(row, col) ~= nil then
          local p = Board.getPieceAt(row, col)
          Board.attack(piece, p)
        end
      end
    end
  end
end

function Board.handleMovement()
  for k, piece in pairs(Board.pieces) do
    for k2, move in pairs(piece.moves) do
      if move.row == col and move.column == row then
        piece.row = col
        piece.column = row
        
        piece:endMove()
        Board.nextPlayer()
      end
    end
  end
end

function Board.attack(attacker, defender)
  if defender.team ~= attacker.team then
    defender.health = defender.health - attacker.damage
    
    if defender.health <= 0 then
      attacker.row = defender.row
      attacker.column = defender.column
      
      defender:onDeath()
    end
    
    attacker:endMove()
    Board.nextPlayer()
  end
end

function Board.getPieceAt(row, column)
  for k, piece in pairs(Board.pieces) do
    if piece.row == column and piece.column == row then
      return piece
    end
  end
end

function Board.getActiveCount()
  local num = 0
  for k, piece in pairs(Board.pieces) do
    if piece.active then
      num = num + 1
    end
  end
  
  return num
end

function Board.nextPlayer()
  if Board.current_player == 1 then
    Board.current_player = 2
  elseif Board.current_player == 2 then
    Board.current_player = 1
  end
end

function Board.update(dt)
  for k, piece in pairs(Board.pieces) do
    piece:update(dt)
  end
  
  Piece.updateSprites(dt)
end

function Board.draw()
  local r, g, b, a = love.graphics.getColor()
  
  love.graphics.setColor(Board.player_one_color[1], 100, Board.player_one_color[3], 255)
  Sprite.draw(Board.side, 210, Constants.SCREEN_HEIGHT / 2)
  
  love.graphics.setColor(Board.player_two_color[1], 100, Board.player_two_color[3], 255)
  Sprite.draw(Board.side, Constants.SCREEN_WIDTH - 210, Constants.SCREEN_HEIGHT / 2)
  
  for row = 1, Constants.NUM_ROWS do
    for col = 1, Constants.NUM_COLUMNS do
      local x = Constants.BOARD_ORIGIN_X + ((row - 1) * (Constants.CELL_WIDTH + Constants.BORDER_SIZE))
      local y = Constants.BOARD_ORIGIN_Y + ((col - 1) * (Constants.CELL_HEIGHT + Constants.BORDER_SIZE)) + Constants.CELL_HEIGHT
      
      if ((row + col) % 2 == 0) then
        love.graphics.setColor(204, 153, 0, 127)
      else
        love.graphics.setColor(102, 51, 0, 127)
      end
      
      love.graphics.rectangle("fill", x, y, Constants.CELL_WIDTH, -Constants.CELL_HEIGHT)
    end
  end
  
  love.graphics.setColor(r, g, b, a)
end

function Board.loadState(file)
  local s = FileHandler.read(file)
end

return Board