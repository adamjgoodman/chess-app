class Piece < ApplicationRecord
  belongs_to :game
  has_many :moves

  def move!(x, y)
    return false unless move_valid?(x, y)
    update_rook_if_castling(x, y)
    update_attributes(x_position: x, y_position: y)
    Move.create(piece_id: id, game_id: game_id, destination_x: x_position, destination_y: y_position)
    update_attributes(type: 'Queen') if promoting_pawn?(y)
  end

  def promoting_pawn?(y)
    type == 'Pawn' && y == 7 || y.zero?
  end

  def update_rook_if_castling(x, y)
    rook_at(7, y).update_attributes(x_position: 5, y_position: y) if castling_kingside?(x, y)
    rook_at(0, y).update_attributes(x_position: 3, y_position: y) if castling_queenside?(x, y)
  end

  def castling_kingside?(x, y)
    x_position - x == -2 && y_position == y
  end

  def castling_queenside?(x, y)
    x_position - x == 2 && y_position == y
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
    return true if (x_position - x).abs == (y_position - y).abs
  end

  # checking to see if the vertical path is obstructed
  def vertical_obstructed?(x, y)
    y_min = [y_position, y].min
    y_max = [y_position, y].max
    (y_min + 1...y_max).each do |y_coord|
      return true if space_occupied?(x, y_coord)
    end
    false
  end

  # checking to see if the horizontal path is obstructed
  def horizontal_obstructed?(x, y)
    x_min = [x_position, x].min
    x_max = [x_position, x].max
    (x_min + 1...x_max).each do |x_coord|
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
end
