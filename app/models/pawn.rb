class Pawn < Piece
  def move_valid?
    # add logic here
  end

  def unicode
    if white
      '&#9817;'
    else
      '&#9823;'
    end
  end
end
