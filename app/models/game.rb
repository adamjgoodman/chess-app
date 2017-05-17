class Game < ApplicationRecord
  scope :available, (-> { where(status: 'available') })
  has_many :pieces
end
