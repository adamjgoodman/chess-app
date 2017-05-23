class Bishop < Piece
  def move_valid?
    # add logic here
  end


def unicode
	if white
		return "&#9815;"
	else
		return "&#9821;"
	end
end
end
