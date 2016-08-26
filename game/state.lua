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
    local s = StringHelper.split(line, ":")
    if (#s == 2) then
      Board.current_player = tonumber(s[2])
    elseif (#s == 6) then
      Piece.red_death_x = tonumber(s[1])
      Piece.red_death_y = tonumber(s[2])
      
      Piece.blue_death_x = tonumber(s[3])
      Piece.blue_death_y = tonumber(s[4])
      
      Piece.red_dead = tonumber(s[5])
      Piece.blue_dead = tonumber(s[6])
    else
      if (line:sub(1, 4) == "Dead") then
        Piece.load(s[2], tonumber(s[3]), tonumber(s[4]), tonumber(s[5]), tonumber(s[6]), tonumber(s[7]), tonumber(s[8]))
      else
        Piece.load(s[1], tonumber(s[2]), tonumber(s[3]), tonumber(s[4]), tonumber(s[5]))
      end
    end
  end
end

return State