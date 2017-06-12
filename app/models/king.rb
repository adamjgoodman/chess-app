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

  def legal_move?(x, y)
    return true if diagonal_legal?(x, y)
    return true if horizontal_legal?(x, y)
    return true if vertical_legal?(x, y)
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

# game.pieces.where(is_black: is_black)
# if moving that piece opens an unobstructed path to the king for game.pieces.where(is_black: !is_black)
# then you cannot move that piece because you will be placing your own king in check
