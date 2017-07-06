class Piece < ApplicationRecord
  belongs_to :game
  has_many :moves

  scope :active, (-> { where(x_position: 0..7, y_position: 0..7) })

  def move?(x, y)
    return false if move_causes_check?(x, y)
    move!(x, y)
  end


  def move!(x, y)
    return false unless move_valid?(x, y)
    capture_happened = update_opponent_if_capture(x, y)
    en_passant_happened = update_opponent_if_en_passant_capture(x, y)
    update_position(x, y)
    update_move_if_promoting_pawn(y)
    update_attributes(type: 'Queen') if promoting_pawn?(y)
    update_move_if_castling(x, y)
    # update_rook_if_castling(x, y)
    update_move_if_capture(x, y) if capture_happened
    update_move_if_capture_en_passant(x, y) if en_passant_happened
    # update_move_if_game_in_check

    true
  end

  def move_causes_check?(x, y)
    state = false
    ActiveRecord::Base.transaction do
      move!(x, y)
      king = Piece.find_by(type: 'King', is_black: is_black, game_id: game_id)
      state = king.in_check?
      raise ActiveRecord::Rollback
    end
    reload
    state
  end

  def update_position(x, y)
    update_attributes(x_position: x, y_position: y)
    Move.create(piece_id: id, game_id: game_id, destination_x: x_position, destination_y: y_position)
  end

  def capture?(x, y)
    opponent_piece_at?(x, y)
  end

  def update_opponent_if_capture(x, y)
    piece_at(x, y).update_attributes(x_position: 8, y_position: 8, status: 'captured') if capture?(x, y)
  end

  def update_opponent_if_en_passant_capture(x, y)
    update_opponent_if_white_capture_en_passant_right(x, y) || # must do this before x_position is updated
      update_opponent_if_white_capture_en_passant_left(x, y) || # change to single en passant method?
      update_opponent_if_black_capture_en_passant_right(x, y) ||
      update_opponent_if_black_capture_en_passant_left(x, y)
  end

  def update_opponent_if_white_capture_en_passant_right(x, y)
    # will exit early if not true - the rest won't run
    return unless type == 'Pawn' && x_position == (x - 1) && !space_occupied?(x, y) && pawn_at(x, (y - 1))
    pawn_at(x, (y - 1)).update_attributes(x_position: 8, y_position: 8, status: 'captured')
  end

  def update_opponent_if_white_capture_en_passant_left(x, y)
    return unless type == 'Pawn' && x_position == (x + 1) && !space_occupied?(x, y) && pawn_at(x, (y - 1))
    pawn_at(x, (y - 1)).update_attributes(x_position: 8, y_position: 8, status: 'captured')
  end

  def update_opponent_if_black_capture_en_passant_left(x, y)
    return unless type == 'Pawn' && x_position == (x - 1) && !space_occupied?(x, y) && pawn_at(x, (y + 1))
    pawn_at(x, (y + 1)).update_attributes(x_position: 8, y_position: 8, status: 'captured')
  end

  def update_opponent_if_black_capture_en_passant_right(x, y)
    return unless type == 'Pawn' && x_position == (x + 1) && !space_occupied?(x, y) && pawn_at(x, (y + 1))
    pawn_at(x, (y + 1)).update_attributes(x_position: 8, y_position: 8, status: 'captured')
  end

  def update_move_if_castling(x, y)
    Move.last.update_attributes(action: 'castles kingside') if castling_kingside?(x, y)
    Move.last.update_attributes(action: 'castles queenside') if castling_queenside?(x, y)
  end

  def update_move_if_capture(_x, _y)
    Move.last.update_attributes(action: 'captures piece')
  end

  def update_move_if_promoting_pawn(y)
    Move.last.update_attributes(action: 'promotes pawn') if promoting_pawn?(y)
  end

  def update_move_if_capture_en_passant(_x, _y)
    Move.last.update_attributes(action: 'captures en passant')
  end

  def update_move_if_game_is_in_check
    Move.last.update_attributes(check: true) if game_in_check?
  end

  def promoting_pawn?(y)
    type == 'Pawn' && (y == 7 || y.zero?)
  end

  def update_rook_if_castling(x, y)
    rook_at(7, y).update_attributes(x_position: 5, y_position: y) if castling_kingside?(x, y)
    rook_at(0, y).update_attributes(x_position: 3, y_position: y) if castling_queenside?(x, y)
  end

  def castling_kingside?(_x, _y)
    type == 'King' && x_position == 6 && moves.count == 1
  end

  def castling_queenside?(_x, _y)
    type == 'King' && x_position == 2 && moves.count == 1
  end

  # a query to check our database and crosscheck to see if the square we want to look up is occupied by another piece
  def space_occupied?(x, y)
    game.pieces.where('x_position = ? AND y_position = ?', x, y).present?
  end

  def opponent_color(x, y)
    game.pieces.find_by(x_position: x, y_position: y).is_black
  end

  # checking to see if the square we want is occupied by a piece of the opponent's color
  def space_occupied_by_opponent?(x, y)
    other_piece = game.pieces.where(x_position: x, y_position: y).first
    other_piece && other_piece.is_black != is_black
  end

  # checking to see what type of move -- vertical, horizontal, or diagonal
  def vertical_move?(x, y)
    return true if x_position == x && y_position != y
  end

  def horizontal_move?(x, y)
    return true if x_position != x && y_position == y
  end

  def diagonal_move?(x, y)
    return true if (x_position - x).abs == (y_position - y).abs && (x_position != x)
  end

  # checking to see if the vertical path is obstructed
  def vertical_obstructed?(x, y)
    y_min = [y_position, y].min
    y_max = [y_position, y].max
    (y_min + 1...y_max - 1).each do |y_coord|
      return true if space_occupied?(x, y_coord)
    end
    false
  end

  # checking to see if the horizontal path is obstructed
  def horizontal_obstructed?(x, y)
    x_min = [x_position, x].min
    x_max = [x_position, x].max
    (x_min + 1...x_max - 1).each do |x_coord|
      return true if space_occupied?(x_coord, y)
    end
    false
  end

  # checking to see if the diagonal path is obstructed

  def diagonal_obstructed?(x, y)
    x_direction = x_position < x ? 1 : -1
    y_direction = y_position < y ? 1 : -1

    current_x = x_position + x_direction
    current_y = y_position + y_direction
    while current_x != x && current_y != y
      return true if space_occupied?(current_x, current_y)
      current_x += x_direction
      current_y += y_direction
    end
    false
  end

  # this method will return false if the path is clear
  def path_obstructed?(x, y)
    return vertical_obstructed?(x, y) if vertical_move?(x, y)
    return horizontal_obstructed?(x, y) if horizontal_move?(x, y)
    return diagonal_obstructed?(x, y) if diagonal_move?(x, y)
    false
  end

  def rook_at(x, y)
    piece = piece_at(x, y)
    piece && piece.type == 'Rook' ? piece : nil
  end

  def pawn_at(x, y)
    piece = piece_at(x, y)
    piece && piece.type == 'Pawn' ? piece : nil
  end

  def piece_at(x, y)
    game.pieces.where(x_position: x, y_position: y).first
  end

  def friendly_piece_at?(x, y)
    piece = piece_at(x, y)
    piece && piece.is_black == is_black
  end

  def opponent_piece_at?(x, y)
    piece = piece_at(x, y)
    piece && piece.is_black == !is_black
  end

  def in_bounds(x, y)
    return false if x > 7 || x < 0 || y > 7 || y < 0
    true
  end
end
