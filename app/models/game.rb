class Game < ApplicationRecord
  scope :available, -> { where(status: 'available') }
end
