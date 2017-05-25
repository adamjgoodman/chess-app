class Game < ApplicationRecord
  belongs_to :user_black, class_name: 'User', foreign_key: 'user_id_black', optional: true
  belongs_to :user_white, class_name: 'User', foreign_key: 'user_id_white', optional: true
  has_many :pieces

  scope :available, (-> { where(status: 'available') })

  def missing_player_color
    if user_id_black.nil?
      'Black'
    else
      'White'
    end
  end

  def host_player
    user_black || user_white
  end
end
