local State = {}

State.running = "Running"
State.game_over = "Game Over"

State.current = State.running

function State.getGameState()
  local s = "Player:" .. Board.current_player .. "\n"
  
  for k, piece in pairs(Board.pieces) do
    s = s .. piece.type .. ":" .. piece.row .. ":" .. piece.column .. ":" .. piece.team .. ":" .. piece.health .. "\n"
  end
  
  return s
end

function State.loadGameState(data)
  local i = 1
  Board.pieces = {}
  for line in data:gmatch("%S+") do
    if (i == 1) then
      local _, player = line:match("([^:]+):([^:]+)")
      Board.current_player = tonumber(player)
    else
      local piece_type, row, column, team, health = line:match("([^:]+):([^:]+):([^:]+):([^:]+):([^:]+)")
      Piece.load(piece_type, tonumber(row), tonumber(column), tonumber(team), tonumber(health))
    end
    
    i = i + 1
  end
end

return State