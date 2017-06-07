module Check
  king = Piece.where(type: "King", color: is_black)
  antagonists = Piece.where(color: !is_black)
  square = king.x_position, king.y_position

  # module should run through each opponent piece on the board and check to see if the king in question is within their range of legal movements.  If it is, it should return check.

  def in_check?(x, y)
    # will evaluate true when in check
  end

  def knight_check?(x, y)
    # will evaluate true when checking
  end

  def rook_check?(x, y)
    # will evaluate true when checking
  end

  def castle_check?(x, y)
    # will evaluate true when checking
  end

  def queen_check(x, y)
    # will evaluate true when checking
  end

  def bishop_check(x, y)
    # will evaluate true when checking
  end

  def antagonist_knight?(x, y)
    antagonist_knight = Piece.where(type: "knight", color: !is_black)
    # will evaluate true when checking
  end

  def antagonist_rook?(x, y)
    antagonist_rook = Piece.where(type: "rook", color: !is_black)
  end

  def antagonist_castle?(x, y)
    antagonist_castle = Piece.where(type: "castle", color: !is_black)
  end

  def antagonist_queen?(x, y)
    antagonist_queen = Piece.where(type: "queen", color: !is_black)
  end

  def antagonist_bishop?(x, y)
    antagonist_bishop = Piece.where(type: "bishop", color: !is_black)
  end
end

# Checkmate the king has no legal move outside being attacked
# Check - the king is in the direct line of attack of an opponent
# if opponent bishop is unobstructed on the diagonal
# if opponent queen is unobstructed on the diaagonal, vertical, or horizontal
# king cannot move next to another king (kings can't check kings cause it puts them in check)
# if valid_move? for king is true, then king won't end up next to opposing king
