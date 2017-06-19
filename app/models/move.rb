class Move < ApplicationRecord
  belongs_to :game
  belongs_to :piece

  def turn
    return user_id_white if game.moves.count % 2 == 0
    user_id_black
  end
end
