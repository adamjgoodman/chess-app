class Move < ApplicationRecord
  belongs_to :game
  belongs_to :piece

  # count the number of moves (count (like length and size)
  # is not a 0 index)
  # If even, black is up.  If odd, white.
  def turn
    if game.moves.count % 2 == 0
      return game.user_id_black
    else
      game.user_id_white
    end
  end
end
