class Pawn < Piece
  def move_valid?(x, y)
    return false if legal_move?(x, y) == false
    true
  end

  # basic one-step move:
  def one_step_legal?(x, y)
    return false if space_occupied?(x, y)
    return true if black_one_step_is_ok(x, y) || white_one_step_is_ok(x, y)
    false
  end

  def black_one_step_is_ok(x, y)
    return true if is_black && (x_position == x && (y_position - y) == 1)
    false
  end

  def white_one_step_is_ok(x, y)
    return true if is_black == false && (x_position == x && (y - y_position) == 1)
    false
  end

  # regular diagonal capture
  def regular_capture_legal?(x, y)
    return false unless space_occupied_by_opposing_color_piece?(x, y)
    return true if black_regular_capture_is_ok(x, y) || white_regular_capture_is_ok(x, y)
    false
  end

  def black_regular_capture_is_ok(x, y)
    return true if black_regular_capture_to_right_is_ok(x, y) || black_regular_capture_to_left_is_ok(x, y)
    false
  end

  def black_regular_capture_to_right_is_ok(x, y)
    return true if is_black && (x_position == x - 1 && (y_position - y) == 1)
    false
  end

  def black_regular_capture_to_left_is_ok(x, y)
    return true if is_black && (x_position == x + 1 && (y_position - y) == 1)
    false
  end

  def white_regular_capture_is_ok(x, y)
    return true if white_regular_capture_to_right_is_ok(x, y) || white_regular_capture_to_left_is_ok(x, y)
    false
  end

  def white_regular_capture_to_right_is_ok(x, y)
    return true if is_black == false && (x_position == x + 1 && (y - y_position) == 1)
    false
  end

  def white_regular_capture_to_left_is_ok(x, y)
    return true if is_black == false && (x_position == x - 1 && (y - y_position) == 1)
    false
  end

  def legal_move?(x, y)
    return true if one_step_legal?(x, y)
    return true if regular_capture_legal?(x, y)
    false
  end

  def unicode
    '&#9823;'
  end
end
