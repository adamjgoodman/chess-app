class Check
  king = Piece.where(type: "King", color: is_black)
  antagonists = Piece.where(color: !is_black)
  square = king.x_position, king.y_position

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
    antagonist_knight = Piece.where(type: "knight")
    # will evaluate true when checking
  end

  def antagonist_rook?(x, y)
    # will evaluate true when checking
  end

  def antagonist_castle?(x, y)
    # will evaluate true when checking
  end

  def antagonist_queen?(x, y)
    # will evaluate true when checking
  end

  def antagonist_bishop?(x, y)
    # will evaluate true when checking
  end
end

# Checkmate the king has no legal move outside being attacked
# Check - the king is in the direct line of attack of an opponent
# if opponent bishop is unobstructed on the diagonal
# if opponent queen is unobstructed on the diaagonal, vertical, or horizontal
# king cannot move next to another king (kings can't check kings cause it puts them in check)
# if valid_move? for king is true, then king won't end up next to opposing king
