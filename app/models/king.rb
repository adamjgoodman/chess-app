class King < Piece
  def move_valid?
    # add logic here
  end

  def self.unicode
	if white
		return "&#9812;"
	else
		return "&#9818;"
	end
  end
  
end
