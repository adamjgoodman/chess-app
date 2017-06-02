class Pawn < Piece
  def move_valid?(x, y)
    return false if space_occupied?(x, y) == true
    return false if legal_move?(x, y) == false
    true
  end

  # basic one-step move:
  def one_step_legal?(x, y)
    return true if black_one_step_is_ok(x, y) || white_one_step_is_ok(x, y)
    false
  end

  def black_one_step_is_ok(x, y)
    return true if is_black? && (x_position == x && (y_position - y) == 1)
    false
  end

  def white_one_step_is_ok(x, y)
    return true if is_black == false && (x_position == x && (y - y_position) == 1)
    false
  end

  def legal_move?(x, y)
    return true if one_step_legal?(x, y)
    false
  end

  def unicode
    '&#9823;'
  end
end
