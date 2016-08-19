local PieceHelper = {}

function PieceHelper.isOnBoard(piece)
  local row_valid = piece.row >= 1 and piece.row <= Constants.NUM_ROWS
  local col_valid = piece.column >= 1 and piece.column <= Constants.NUM_COLUMNS
  return row_valid and col_valid
end

function PieceHelper.movePossible(move)
  if PieceHelper.isOnBoard(move) then
    return Board.getPieceAt(move.column, move.row) == nil
  else
    return false
  end
end

function PieceHelper.attackPossible(piece, move)
  if PieceHelper.isOnBoard(move) then
    if Board.getPieceAt(move.column, move.row) then
      local other = Board.getPieceAt(move.column, move.row)
      return other.team ~= piece.team
    else
      return false
    end
  else
    return false
  end
end

return PieceHelper