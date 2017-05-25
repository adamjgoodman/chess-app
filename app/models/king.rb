class King < Piece
  def move_valid?(x, y)
    return false if space_occupied?(x, y) == true
    return false if legal_move?(x, y) == false
    return true
  end

  def legal_move?(x, y)
    return false if (x_position - x).abs != 1 && y_position == y
    return false if x_position == x && (y_position - y).abs != 1
    return false if (x_position - x).abs != 1 && (y_position - y).abs != 1
    return true
  end
end
