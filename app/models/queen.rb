class Queen < Piece
  def move_valid?(x, y)
    return false if space_occupied?(x, y) == true
    return false if legal_move?(x, y) == false
    true
  end

  def diagonal_legal?(x, y)
    # add logic here
  end

  def horizontal_legal?(x, y)
    # add logic here
  end

  def vertical_legal?(x, y)
    # add logic here
  end

  def legal_move?(x, y)
    # add logic here
  end
end
