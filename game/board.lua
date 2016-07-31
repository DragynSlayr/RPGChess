local Board = {}
Piece = require("game.piece")

function Board.load()
  Board.pieces = {}
  
  Board.player_one_color = {255, 0, 0}
  Board.player_two_color = {0, 0, 255}
  
  Board.fill()
  
  Board.sprite = Sprite.load("background/board.tga", 1080, 1080)
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
  for k, piece in pairs(Board.pieces) do 
    if piece.active then 
      piece.row = col
      piece.column = row
      piece.active = false
      piece.moves = {}
    else
      if piece.row == col and piece.column == row then
        piece:onClick(1)
      end
    end
  end
end

function Board.update(dt)
    for k, piece in pairs(Board.pieces) do
      piece:update(dt)
    end
end

function Board.draw()
  Sprite.draw(Board.sprite, Constants.SCREEN_WIDTH / 2, Constants.SCREEN_HEIGHT / 2)
  
  local r, g, b = love.graphics.getColor()
  love.graphics.setColor(0, 0, 0)
  
  for i = 1, Constants.NUM_COLUMNS do
    for j = 1, Constants.NUM_ROWS do
      love.graphics.print(string.format("(%d, %d)", j, i), Constants.BOARD_ORIGIN_X + ((i - 1) * (Constants.CELL_WIDTH + Constants.BORDER_SIZE)), Constants.BOARD_ORIGIN_Y + ((j - 1) * (Constants.CELL_HEIGHT + Constants.BORDER_SIZE)))
    end
  end
  
  for k, piece in pairs(Board.pieces) do 
    piece:draw()
  end
  
  love.graphics.setColor(r, g, b)
end

return Board