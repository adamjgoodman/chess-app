class King < Piece
  def move_valid?(x, y)
    return false if space_occupied?(x, y) == true && opponent_color(x, y) == is_black?
    # will add capture logic
    return false if legal_move?(x, y) == false
    true
  end

  def diagonal_legal?(x, y)
    return (x_position - x).abs == 1 && (y_position - y).abs == 1 if diagonal_move?(x, y)
    false
  end

  def horizontal_legal?(x, y)
    return (x_position - x).abs == 1 && y_position == y if horizontal_move?(x, y)
    false
  end

  def vertical_legal?(x, y)
    return x_position == x && (y_position - y).abs == 1 if vertical_move?(x, y)
    false
  end

  def opposing_king?(x, y)
    # cannot move king to a position adjacent to his opposite
  end

  def legal_move?(x, y)
    return true if diagonal_legal?(x, y)
    return true if horizontal_legal?(x, y)
    return true if vertical_legal?(x, y)
    false
  end

  def unicode
    '&#9818;'
  end
end
