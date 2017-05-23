class King < Piece
  def move_valid?
    # add logic here
  end

  def unicode
    if white
      '&#9812;'
    else
      '&#9818;'
    end
  end
end
