class Knight < Piece
  def move_valid?
    # add logic here
  end

  
def unicode
	if white
		return "&#9816;"
	else
		return "&#9822;"
	end
end
end
