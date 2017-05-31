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

  def initialize_board
    # Building out white pieces
    (0..7).each do |x|
      Pawn.create(is_black: false, x_position: x, y_position: 1, game_id: id, user_id: user_id_white, status: 'available')
    end

    Rook.create(is_black: false, x_position: 0, y_position: 0, game_id: id, user_id: user_id_white, status: 'available')
    Rook.create(is_black: false, x_position: 7, y_position: 0, game_id: id, user_id: user_id_white, status: 'available')

    Knight.create(is_black: false, x_position: 1, y_position: 0, game_id: id, user_id: user_id_white, status: 'available')
    Knight.create(is_black: false, x_position: 6, y_position: 0, game_id: id, user_id: user_id_white, status: 'available')

    Bishop.create(is_black: false, x_position: 2, y_position: 0, game_id: id, user_id: user_id_white, status: 'available')
    Bishop.create(is_black: false, x_position: 5, y_position: 0, game_id: id, user_id: user_id_white, status: 'available')

    King.create(is_black: false, x_position: 4, y_position: 0, game_id: id, user_id: user_id_white, status: 'available')
    Queen.create(is_black: false, x_position: 3, y_position: 0, game_id: id, user_id: user_id_white, status: 'available')

    # Building out the black pieces
    (0..7).each do |x|
      Pawn.create(is_black: true, x_position: x, y_position: 6, game_id: id, user_id: user_id_black, status: 'available')
    end

    Rook.create(is_black: true, x_position: 0, y_position: 7, game_id: id, user_id: user_id_black, status: 'available')
    Rook.create(is_black: true, x_position: 7, y_position: 7, game_id: id, user_id: user_id_black, status: 'available')

    Knight.create(is_black: true, x_position: 1, y_position: 7, game_id: id, user_id: user_id_black, status: 'available')
    Knight.create(is_black: true, x_position: 6, y_position: 7, game_id: id, user_id: user_id_black, status: 'available')

    Bishop.create(is_black: true, x_position: 2, y_position: 7, game_id: id, user_id: user_id_black, status: 'available')
    Bishop.create(is_black: true, x_position: 5, y_position: 7, game_id: id, user_id: user_id_black, status: 'available')

    King.create(is_black: true, x_position: 4, y_position: 7, game_id: id, user_id: user_id_black, status: 'available')
    Queen.create(is_black: true, x_position: 3, y_position: 7, game_id: id, user_id: user_id_black, status: 'available')
  end
end
