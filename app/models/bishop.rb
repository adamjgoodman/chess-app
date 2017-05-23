class Bishop < Piece
  def move_valid?
    # add logic here
  end

  def unicode
    if white
      '&#9815;'
    else
      '&#9821;'
    end
  end
end
