local Piece = {}

Bishop = require("pieces.bishop")
King = require("pieces.king")
Knight = require("pieces.knight")
Pawn = require("pieces.pawn")
Queen = require("pieces.queen")
Rook = require("pieces.rook")

function Piece.newPiece(row, column, color)
  local piece = {}
  
  piece.row = column
  piece.column = row
  
  piece.color = color
  
  return piece
end

return Piece