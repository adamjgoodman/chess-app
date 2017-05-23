class Pawn < Piece
  def move_valid?
    # add logic here
  end

  
def unicode
	if white
		return "&#9817;"
	else
		return "&#9823;"
	end
end
end
