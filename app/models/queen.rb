class Queen < Piece
  def move_valid?
    # add logic here
  end

  #Queen
def unicode
	if self.white
		return "&#9813;"
	else
		return "&#9819;"
	end
end

end
