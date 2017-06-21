class Move < ApplicationRecord
  belongs_to :game
  belongs_to :piece

  def algebra_x
        if destination_x == 0
            return a
        elsif destination_x == 1
            return b
        elsif destination_x == 2
            return c
        elsif destination_x == 3
            return d
        elsif destination_x == 4
            return e
        elsif destination_x == 5
            return f
        elsif destination_x == 6
            return g
        else
            h
      end

  def algebra_y
    return destination_y + 1
  end

  def destination
    algebra_x algebra_y
  end

    def to_algebra
    if action == 'castles kingside'
        return 'O-O'

    elsif action == 'castles queenside'
        return 'O-O-O'

    elsif action = 'captures piece'
        return 'destination &#x2020;'

    elsif action == 'promotes pawn'
        return 'destination promotes'

    elsif action == 'captures en passant'
        return 'destination ep&#x2020;'

    elsif check == true
        return 'destination check'

    else
            destination
    end


end
