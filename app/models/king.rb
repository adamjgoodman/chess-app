class King < Piece

  def move_valid?(x, y)
    while
      space_occupied?(x, y) == false # I think I can pull this straight from pieces
      legal_move?(x, y) == true
      check?(x, y) == false
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

  # King is not allowed to put himself in check.  This retrieves the position of the opposing king
  # def check?(x, y)
  #   White = Self.find_by_color("white")
  #   Black = Self.find_by_color("black")

  # end

end

