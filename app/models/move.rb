class Move < ApplicationRecord
  belongs_to :game
  belongs_to :piece

  # If even, black is up.  If odd, white.
  def turn
    return game.user_id_white if game.moves.count.even?
    game.user_id_black
  end
end
