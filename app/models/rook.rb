class Rook < Piece
  def move_valid?(x, y)
    return false unless vertical_move?(x, y) || horizontal_move?(x, y)
    return false if path_obstructed?(x, y)
    return false if friendly_piece_at?(x, y)
    true
  end

  def unicode
    '&#9820;'
  end
end
