class Rook < Piece
  def move_valid?
    # add logic here
  end
  
def unicode
	if white
		return "&#9814;"
	else
		return "&#9820;"
	end
end
end
