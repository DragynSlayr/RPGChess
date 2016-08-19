local Driver = {}
State = require("game.state")
Board = require("game.board")

Driver.font = love.graphics.newFont("assets/fonts/op.ttf", 100)
Driver.end_string = "G  ame  Over"

Board.current_player = 1

function Driver.mousePressed(x, y, button, is_touch)
  if button == 3 then
    love.event.quit()
  end
  
  if (State.current == State.running) then
    if Board.getLocation(x, y) ~= nil then
      row, col = Board.getLocation(x, y)
      Board.checkClick(row, col, button)
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
  if (State.current == State.running) then
    Board.update(dt)
  elseif (State.current == State.game_over) then
    
  end
end

function Driver.draw()
  if (State.current == State.running) then
    Board.draw()
  elseif (State.current == State.game_over) then
    love.graphics.setFont(Driver.font)
    love.graphics.printf(Driver.end_string, 0, (Constants.SCREEN_HEIGHT - Driver.font:getHeight(Driver.end_string)) / 2, Constants.SCREEN_WIDTH, "center")
  end
end

return Driver