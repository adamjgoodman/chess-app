class Queen < Piece
  def move_valid?
    # add logic here
  end

  def unicode
    if white
      '&#9813;'
    else
      '&#9819;'
    end
  end
end
