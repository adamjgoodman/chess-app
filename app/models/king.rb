class King < Piece
  def move_valid?(x, y)
    return false if space_occupied?(x, y) == true && opponent_color(x, y) == is_black
    return false if legal_move?(x, y) == false
    return false if in_check? == true
    true
  end

  def diagonal_legal?(x, y)
    return (x_position - x).abs == 1 && (y_position - y).abs == 1 if diagonal_move?(x, y)
    false
  end

  def horizontal_legal?(x, y)
    return (x_position - x).abs == 1 && y_position == y if horizontal_move?(x, y)
    false
  end

  def vertical_legal?(x, y)
    return x_position == x && (y_position - y).abs == 1 if vertical_move?(x, y)
    false
  end

  def castle_kingside_legal?(x, y)
    return false if !rook_at(7, y) || rook_at(7, y).moves.count != 0
    return true if x == 6
    false
  end

  def castle_queenside_legal?(x, y)
    return false if !rook_at(0, y) || rook_at(0, y).moves.count != 0
    return false if space_occupied?(1, 0)
    return true if x == 2
    false
  end

  def castle_legal?(x, y)
    # if the king has previously moved, castling is illegal:
    return false if moves.count != 0
    return false if horizontal_obstructed?(x, y)
    return true if castle_kingside_legal?(x, y) || castle_queenside_legal?(x, y)
    false
  end

  def legal_move?(x, y)
    return true if diagonal_legal?(x, y)
    return true if horizontal_legal?(x, y)
    return true if vertical_legal?(x, y)
    return true if castle_legal?(x, y)
    false
  end

  # returns true if king is in check
  def in_check?
    game.pieces.where(is_black: !is_black).each do |piece|
      return true if piece.valid_move?(x_position, y_position)
    end
    false
  end

  def unicode
    '&#9818;'
  end
end
