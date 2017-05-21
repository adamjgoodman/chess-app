class Game < ApplicationRecord
  belongs_to :user_black, class_name: 'User', foreign_key: 'user_id_black', optional: true
  belongs_to :user_white, class_name: 'User', foreign_key: 'user_id_white', optional: true
  has_many :pieces

  scope :available, (-> { where(status: 'available') })

  def missing_player_color
    if user_id_black.nil?
      'White'
    else
      'Black'
    end
  end

  def host_player
    user_black || user_white
  end

  def initialize_board
      # Building out white pieces
    (0..7).each do |x|
    Pawn.create(white: true, x_position: x, y_position: 2, game_id: id, user_id: user_id_white, status: "active")
    end

    Rook.create(white: true, x_position: 0, y_position: 0, game_id: id, user_id: user_id_white, status: "active")
    Rook.create(white: true, x_position: 0, y_position: 7, game_id: id, user_id: user_id_white, status: "active")

    Knight.create(white: true, x_position: 0, y_position: 1, game_id: id, user_id: user_id_white, status: "active")
    Knight.create(white: true, x_position: 0, y_position: 6, game_id: id, user_id: user_id_white, status: "active")

    Bishop.create(white: true, x_position: 0, y_position: 2, game_id: id, user_id: user_id_white, status: "active")
    Bishop.create(white: true, x_position: 0, y_position: 5, game_id: id, user_id: user_id_white, status: "active")

    King.create(white: true, x_position: 0, y_position: 4, game_id: id, user_id: user_id_white, status: "active")
    Queen.create(white: true, x_position: 0, y_position: 3, game_id: id, user_id: user_id_white, status: "active")


    # Building out the black pieces
    (0..7).each do |x|
    Pawn.create(black: true, x_position: x, y_position: 6, game_id: id, user_id: user_id_black, status: "active")
    end

    Rook.create(black: true, x_position: 7, y_position: 0, game_id: id, user_id: user_id_black, status: "active")
    Rook.create(black: true, x_position: 7, y_position: 7, game_id: id, user_id: user_id_black, status: "active")

    Knight.create(black: true, x_position: 7, y_position: 1, game_id: id, user_id: user_id_black, status: "active")
    Knight.create(black: true, x_position: 7, y_position: 6, game_id: id, user_id: user_id_black, status: "active")

    Bishop.create(black: true, x_position: 7, y_position: 2, game_id: id, user_id: user_id_black, status: "active")
    Bishop.create(black: true, x_position: 7, y_position: 5, game_id: id, user_id: user_id_black, status: "active")

    King.create(black: true, x_position: 7, y_position: 4, game_id: id, user_id: user_id_black, status: "active")
    Queen.create(black: true, x_position: 7, y_position: 3, game_id: id, user_id: user_id_black, status: "active")
  end
end
