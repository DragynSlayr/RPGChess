local Board = {}

function Board.load()
  Board.pieces = {}
  
  Board.sprite = Sprite.load("background/board.tga", 1080, 1080)
end

function Board.getLocation(x, y)
  local x, y = x - Constants.BOARD_ORIGIN_X, y - Constants.BOARD_ORIGIN_Y
  
  local x_valid = x >= 0 and x <= Constants.BOARD_WIDTH - (2 * Constants.BORDER_SIZE)
  local y_valid = y >= 0 and y <= Constants.BOARD_HEIGHT - (2 * Constants.BORDER_SIZE)
  
  if (x_valid and y_valid) then
    local row = math.ceil(y / (Constants.CELL_HEIGHT + Constants.BORDER_SIZE))
    local column = math.ceil(x / (Constants.CELL_WIDTH + Constants.BORDER_SIZE))

    return row, column
  end
end

function Board.update(dt)
end

function Board.drawAt(row, column)
  local j = (Constants.BOARD_ORIGIN_Y + ((row - 1) * (Constants.CELL_HEIGHT + Constants.BORDER_SIZE))) + (Constants.CELL_HEIGHT / 2)
  local i = (Constants.BOARD_ORIGIN_X + ((column - 1) * (Constants.CELL_WIDTH + Constants.BORDER_SIZE))) + (Constants.CELL_WIDTH / 2)
  
  local r, g, b = love.graphics.getColor()
  love.graphics.setColor(0, 0, 0)
  
  love.graphics.circle("fill", i, j, 10)
  
  love.graphics.setColor(r, g, b)
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
  
  love.graphics.setColor(r, g, b)
end

return Board