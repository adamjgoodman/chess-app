class Move < ApplicationRecord
  belongs_to :game
  belongs_to :piece

  # def turn
  #   if game.move_id % 2 == 0
  #     return user_id_black
  #   else
  #     return user_id_white
  #   end
  # end

end
