class Pawn < Piece
  def move_valid?(x, y)
    return true if one_step_legal?(x, y)
    return true if regular_capture_legal?(x, y)
    return true if capture_en_passan_legal?(x, y)
    false
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
    return false unless space_occupied_by_opponent_color_piece?(x, y)
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

  # capture en passant
  def capture_en_passant_legal?(x, y)
    return true if black_capture_en passant_is_ok(x, y) || white_capture_en_passant_is_ok(x, y)
    false
  end

  def white_capture_en_passant_is_ok?(x, y)
    return true if white_capture_en_passant_to_right_is_ok(x, y) || white_capture_en_passant_to_left_is_ok(x, y)
    false
  end

  def white_capture_en_passant_to_right_is_ok?(x, y)
    pawn = pawn_at((x_position + 1), 4)
    return false unless pawn && pawn.is_black && pawn_at(x + 1, 4).moves.count == 1
    return false unless x == x_position + 1 && y == 3
    true
  end

  def white_capture_en_passant_to_left_is_ok?(x, y)
    pawn = pawn_at((x_position - 1), 4)
    return false unless pawn && pawn.is_black && pawn_at(x + 1, 4).moves.count == 1
    return false unless x == x_position - 1 && y == 3
    true
  end

  def black_capture_en_passant_is_ok?(x, y)
    return true if black_capture_en_passant_to_right_is_ok(x, y) || black_capture_en_passant_to_left_is_ok(x, y)
    false
  end

  def black_capture_en_passant_to_right_is_ok?(x, y)
    pawn= pawn_at((x_position -1), 3
    return false unless pawn && !pawn.is_black && pawn_at(x - 1, 3).moves.count == 1
    return false unless x == x_position - 1 && y == 3
    true
  end

  def black_capture_en_passant_to_left_is_ok?(x, y)
    pawn = pawn_at((x_position + 1), 3)
    return false unless pawn && !pawn.is_black && pawn_at(x + 1, 3).moves.count == 1
    return false unless x == x_position + 1 && y == 3
    true
  end


  def unicode
    '&#9823;'
  end
end
