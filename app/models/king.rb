class King < Piece
  def move_valid?
    # add logic here
  end

  def unicode
	if white
		return "&#9812;"
	else
		return "&#9818;"
	end
  end
  
end
