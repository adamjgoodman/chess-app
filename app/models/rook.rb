class Rook < Piece
  def move_valid?
    # add logic here
  end

  #Rook
def unicode
	if self.white
		return "&#9814;"
	else
		return "&#9820;"
	end
end
end
