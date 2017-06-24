class Queen < Piece
  def move_valid?(x, y)
    return false unless diagonal_move?(x, y) ||  horizontal_move?(x, y) || vertical_move?(x, y)
    return false if path_obstructed?(x, y)
    return false if friendly_piece_at?(x, y)
    true
  end

  # def diagonal_legal?(x, y)
  #   return true if diagonal_move?(x, y) && !path_obstructed?(x, y)
  #   false
  # end

  # def horizontal_legal?(x, y)
  #   return true if horizontal_move?(x, y) && !path_obstructed?(x, y)
  #   false
  # end

  # def vertical_legal?(x, y)
  #   return true if vertical_move?(x, y) && !path_obstructed?(x, y)
  #   false
  # end

  # def legal_move?(x, y)
  #   return true if diagonal_legal?(x, y) == true
  #   return true if horizontal_legal?(x, y) == true
  #   return true if vertical_legal?(x, y) == true
  #   false
  # end

  # # evaluates false if the piece in the space is an ally
  # def opponent_occupied?(x, y)
  #   return false if space_occupied?(x, y) == true && opponent_color(x, y) == is_black
  #   true
  # end

  # def self_check?(x, y)
  #   if piece.user_id = user_id_black
  # end

  def unicode
    '&#9819;'
  end
end
