class Rook < Piece
  def move_valid?
    # add logic here
  end

  def unicode
    if white
      '&#9814;'
    else
      '&#9820;'
    end
  end
end
