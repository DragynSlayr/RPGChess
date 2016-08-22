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
    Renderer.add(function() Sprite.draw(Board.sprite, Constants.SCREEN_WIDTH / 2, Constants.SCREEN_HEIGHT / 2) end, 1)
    Renderer.add(Board.draw, 2)
    Renderer.add(Piece.drawMoves, 3)
    Renderer.add(Piece.drawAttacks, 3)
    Renderer.add(Piece.drawBG, 4)
    Renderer.add(Piece.drawHealth, 5)
    Renderer.add(Piece.drawBG, 6)
    Renderer.add(Piece.drawSprite, 7)
  elseif (State.current == State.game_over) then
    
  end
end

function Driver.draw()
  if (State.current == State.running) then
    Renderer.render()
  elseif (State.current == State.game_over) then
    love.graphics.setFont(Driver.font)
    love.graphics.printf(Driver.end_string, 0, (Constants.SCREEN_HEIGHT / 2) - Driver.font:getHeight(Driver.end_string), Constants.SCREEN_WIDTH, "center")
  end
end

return Driver