class Knight < Piece
  def move_valid?
    # add logic here
  end

  #Knight
def unicode
	if self.white
		return "&#9816;"
	else
		return "&#9822;"
	end
end
end
