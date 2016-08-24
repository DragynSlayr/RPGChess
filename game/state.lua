local State = {}

State.running = "Running"
State.game_over = "Game Over"

State.current = State.running

function State.getGameState()
  local s = "Player:" .. Board.current_player .. "\n"
  
  for k, piece in pairs(Board.pieces) do
    s = s .. piece.type .. ":" .. piece.row .. ":" .. piece.column .. ":" .. piece.team .. ":" .. piece.health .. "\n"
  end
  
  for k, piece in pairs(Board.graveyard) do
    s = s .. "Dead" .. ":" .. piece.type .. ":" .. piece.row .. ":" .. piece.column .. ":" .. piece.team .. ":" .. piece.health .. ":" .. piece.death_x .. ":" .. piece.death_y .. "\n"
  end
  
  s = s .. Piece.red_death_x .. ":" .. Piece.red_death_y .. ":" .. Piece.blue_death_x .. ":" .. Piece.blue_death_y .. ":" .. Piece.red_dead .. ":" .. Piece.blue_dead .. "\n"
  
  return s
end

function State.loadGameState(data)
  Board.pieces = {}
  for line in data:gmatch("%S+") do
    if (line:sub(1, 6) == "Player") then
      local _, player = line:match("([^:]+):([^:]+)")
      Board.current_player = tonumber(player)
    elseif (StringHelper.countSub(line, ":") == 5) then
      local x1, y1, x2, y2, d1, d2 = line:match("([^:]+):([^:]+):([^:]+):([^:]+):([^:]+):([^:]+)")
      
      Piece.red_death_x = tonumber(x1)
      Piece.red_death_y = tonumber(y1)
      
      Piece.blue_death_x = tonumber(x2)
      Piece.blue_death_y = tonumber(y2)
      
      Piece.red_dead = tonumber(d1)
      Piece.blue_dead = tonumber(d2)
    else
      if (line:sub(1, 4) == "Dead") then
        local _, piece_type, row, column, team, health, x, y = line:match("([^:]+):([^:]+):([^:]+):([^:]+):([^:]+):([^:]+):([^:]+):([^:]+)")
        Piece.load(piece_type, tonumber(row), tonumber(column), tonumber(team), tonumber(health), tonumber(x), tonumber(y))
      else
        local piece_type, row, column, team, health = line:match("([^:]+):([^:]+):([^:]+):([^:]+):([^:]+)")
        Piece.load(piece_type, tonumber(row), tonumber(column), tonumber(team), tonumber(health))
      end
    end
  end
end

return State