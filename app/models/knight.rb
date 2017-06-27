class Knight < Piece
  def move_valid?(x, y)
    return false if friendly_piece_at?(x, y)
    return true if upper_right_diagonal_legal?(x, y)
    return true if lower_right_diagonal_legal?(x, y)
    return true if upper_left_diagonal_legal?(x, y)
    return true if lower_left_diagonal_legal?(x, y)
    false
  end

  def upper_right_diagonal_legal?(x, y)
    (x_position + 1 == x && y_position - 2 == y) || (x_position + 2 == x && y_position - 1 == y)
  end

  def lower_right_diagonal_legal?(x, y)
    (x_position + 2 == x && y_position + 1 == y) || (x_position + 1 == x && y_position + 2 == y)
  end

  def upper_left_diagonal_legal?(x, y)
    (x_position - 2 == x && y_position - 1 == y) || (x_position - 1 == x && y_position - 2 == y)
  end

  def lower_left_diagonal_legal?(x, y)
    (x_position - 1 == x && y_position + 2 == y) || (x_position - 2 == x && y_position + 1 == y)
  end

  def unicode
    '&#9822;'
  end
end
