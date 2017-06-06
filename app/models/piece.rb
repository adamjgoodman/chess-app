class Piece < ApplicationRecord
  belongs_to :game

  def move!(x, y)
    return false unless valid_move?(x, y)
    update_attributes(x_position: new_x, y_position: new_y)
    # Move.create(piece_id: id)
  end

  # a query to check our database and crosscheck to see if the square we want to look up is occupied by another piece
  def space_occupied?(x, y)
    game.pieces.where('x_position = ? AND y_position = ?', x, y).present?
  end

  # checking to see if the square we want is occupied by a piece of the same color or opposing color
  def piece_opposing_color
      @piece = Piece.find(:id)
      @piece.is_black ? false : true
  end

  def piece_same_color
      @piece = Piece.find(:id)
      @piece.is_black ? true : false
  end

  def space_occupied_by_opposing_color_piece?(x, y)
    game.pieces.where('x_position = ? AND y_position = ? AND is_black = ?', x, y, piece_opposing_color).present?
  end

  def space_occupied_by_same_color_piece?(x, y)
    game.pieces.where('x_position = ? AND y_position = ? AND is_black = ?', x, y, piece_same_color).present?
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
end
