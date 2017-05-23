class Bishop < Piece
  def move_valid?
    # add logic here
  end

  #Bishop
def self.unicode
	if self.white
		return "&#9815;"
	else
		return "&#9821;"
	end
end
end
