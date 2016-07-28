local Driver = {}
Board = require("game.board")

local row, col = nil, nil

function Driver.mousePressed(x, y, button, is_touch)
  if debugging then
    if Board.getLocation(x, y) ~= nil then
      row, col = Board.getLocation(x, y)
    end
  end
end

function Driver.keyPressed(key, scan_code, is_repeat)
  if key == "escape" then
    love.event.quit()
  end
end

function Driver.load()
  Board.load()
end

function Driver.update(dt)
  Board.update(dt)
end

function Driver.draw()
  Board.draw()
  if row and col then
    Board.drawAt(row, col)
  end
end

return Driver