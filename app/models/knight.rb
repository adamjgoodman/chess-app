class Knight < Piece
  def move_valid?
    # add logic here
  end

  def unicode
    if white
      '&#9816;'
    else
      '&#9822;'
    end
  end
end
