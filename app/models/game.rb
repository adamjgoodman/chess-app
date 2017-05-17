class Game < ApplicationRecord
  belongs_to :user_black, class_name: 'User', foreign_key: 'user_id_black', optional: true
  belongs_to :user_white, class_name: 'User', foreign_key: 'user_id_white', optional: true

  scope :available, (-> { where(status: 'available') })

  def missing_player_color
    self.user_id_black != nil ? "White" : "Black"
  end

  def host_player
    self.user_black || self.user_white
  end
end
