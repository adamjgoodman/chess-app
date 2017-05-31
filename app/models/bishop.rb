class Bishop < Piece
  def move_valid?(x, y)
    # if landing spot is occupied, check to see if is opponent's piece
    if space_occupied?(x, y)
      return false if black? == opponent_color(x, y) # return false if piece is same color
    end
    return false if legal_move?(x, y) == false
    true
  end

  def legal_move?(x, y)
    return true if diagonal_move?(x, y) && !path_obstructed?(x, y)
    false
  end

  def unicode
    '&#9821;'
  end
end
