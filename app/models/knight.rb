class Knight < Piece
  def move_valid?(x, y)
    if x_position+1 == x && y_position+2 == y
      true
    elsif x_position+2 == x && y_position+1 == y
      true
    elsif x_position-1 == x && y_position+2 == y
      true
    else
      false
    end
  end
end
