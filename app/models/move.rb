class Move < ApplicationRecord
  belongs_to :game
  belongs_to :piece

  def turn
    if game.move.count % 2 == 0
      return user_id_white
    else
      return user_id_black
    end
  end

end
