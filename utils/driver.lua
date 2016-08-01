local Driver = {}
Board = require("game.board")

Board.current_player = 1

function Driver.mousePressed(x, y, button, is_touch)
  if button == 3 then
    love.event.quit()
  end
  
  if Board.getLocation(x, y) ~= nil then
    row, col = Board.getLocation(x, y)
    Board.checkClick(row, col, button)
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
end

return Driver