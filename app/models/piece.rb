class Piece < ApplicationRecord
  belongs_to :user
  belongs_to :game

  #a query to check our database and crosscheck to see if the square we want to look up is occupied by another piece
def space_occupied?(x,y)
  game.pieces.where("x_position == x AND y_position == y").present?
end

#checking to see what type of move -- vertical, horizontal, or diagonal
def vertical_move?(x,y)
  return true if x_position == x && y_position != y
end

def horizontal_move?(x,y)
  return true if x_position != x && y_position == y
end

def diagonal_move?(x,y)
  return true if (x_position-x).abs == (y_position-y).abs
end

#checking to see if the vertical path is obstructed
def vertical_obstructed?(x,y)
  y_min = [y_position, y].min
  y_max = [y_position, y].max
  (y_min+1...y_max).each do |y|
    return true if space_occupied?(x,y)
  end
end

#checking to see if the horizontal path is obstructed
def horizontal_obstructed?(x,y)
  x_min = [x_position, x].min
  x_max = [x_position, x].max  
  (x_min+1...x_max).each do |x|
    return true if space_occupied?(x,y)
  end
end

#checking to see if the diagonal path is obstructed

def diagonal_obstructed?(x,y)
  if x > x_position && y > y_position
    (x_position+1...x).zip(y_position+1...y) { |x,y|
      return true if space_occupied?(x,y) } 
  elsif x < x_position && y > y_position
    ((x_position-1).downto(x+1)).zip(y_position+1...y+1) {|x,y|
      return true if space_occupied?(x,y) }
  elsif x > x_position && y < y_position
    (x_position+1...x).zip((y_position-1).downto(y+1)) {|x,y|
      return true if space_occupied?(x,y)  }
  else
    ((x_position-1).downto(x+1)).zip((y_position-1).downto(y+1)) {|x,y|
      return true if space_occupied?(x,y) }
  end
end

# this method will return false if the path is clear
def is_obstructed?(x,y)
  return vertical_obstructed?(x,y) if vertical_move?(x,y)
  return horizontal_obstructed?(x,y) if horizontal_move?(x,y)
  return diagonal_obstructed?(x,y) if diagonal_move?(x,y)
  false
end
end
