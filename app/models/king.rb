class King < Piece
  def move_valid?(x, y)
    if
      space_occupied?(x, y) == false
      legal_move?(x, y) == true
      # check?(x, y) == false <when we have this logic
    end
  end

  def legal_move?(x, y)
    case
    when
    (x_position - x).abs == 1 && y_position == y
      return true
    when
    x_position == x && (y_position - y).abs == 1
      return true
    when
    (x_position - x).abs == 1 && (y_position - y).abs == 1
      return true
    else
      return false
    end
  end
end
