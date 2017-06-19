class Game < ApplicationRecord
  belongs_to :user_black, class_name: 'User', foreign_key: 'user_id_black', optional: true
  belongs_to :user_white, class_name: 'User', foreign_key: 'user_id_white', optional: true
  has_many :pieces
  has_many :moves

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

  def reset_piece_players
    pieces.where(is_black: true).update_all(user_id: user_id_black)
    pieces.where(is_black: false).update_all(user_id: user_id_white)
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable MethodLength

  def initialize_board
    # Building out white pieces
    (0..7).each do |x|
      Pawn.create(is_black: false, x_position: x, y_position: 1, game_id: id, user_id: user_id_white, status: 'active')
    end

    Rook.create(is_black: false, x_position: 0, y_position: 0, game_id: id, user_id: user_id_white, status: 'active')
    Rook.create(is_black: false, x_position: 7, y_position: 0, game_id: id, user_id: user_id_white, status: 'active')

    Knight.create(is_black: false, x_position: 1, y_position: 0, game_id: id, user_id: user_id_white, status: 'active')
    Knight.create(is_black: false, x_position: 6, y_position: 0, game_id: id, user_id: user_id_white, status: 'active')

    Bishop.create(is_black: false, x_position: 2, y_position: 0, game_id: id, user_id: user_id_white, status: 'active')
    Bishop.create(is_black: false, x_position: 5, y_position: 0, game_id: id, user_id: user_id_white, status: 'active')

    King.create(is_black: false, x_position: 4, y_position: 0, game_id: id, user_id: user_id_white, status: 'active')
    Queen.create(is_black: false, x_position: 3, y_position: 0, game_id: id, user_id: user_id_white, status: 'active')

    # Building out the black pieces
    (0..7).each do |x|
      Pawn.create(is_black: true, x_position: x, y_position: 6, game_id: id, user_id: user_id_black, status: 'active')
    end

    Rook.create(is_black: true, x_position: 0, y_position: 7, game_id: id, user_id: user_id_black, status: 'active')
    Rook.create(is_black: true, x_position: 7, y_position: 7, game_id: id, user_id: user_id_black, status: 'active')

    Knight.create(is_black: true, x_position: 1, y_position: 7, game_id: id, user_id: user_id_black, status: 'active')
    Knight.create(is_black: true, x_position: 6, y_position: 7, game_id: id, user_id: user_id_black, status: 'active')

    Bishop.create(is_black: true, x_position: 2, y_position: 7, game_id: id, user_id: user_id_black, status: 'active')
    Bishop.create(is_black: true, x_position: 5, y_position: 7, game_id: id, user_id: user_id_black, status: 'active')

    King.create(is_black: true, x_position: 4, y_position: 7, game_id: id, user_id: user_id_black, status: 'active')
    Queen.create(is_black: true, x_position: 3, y_position: 7, game_id: id, user_id: user_id_black, status: 'active')
  end

  # rubocop:enable Metrics/AbcSize
  # rubocop:enable MethodLength

  def black_in_check?
    # identify the black king on the board
    black_king = King.active.where(is_black: true).first
    black_king.in_check?
    # calls the in_check? method in king.rb
  end

  def white_in_check?
    # identify the white kings on the board and calls on the in_check method in king.rb
    white_king = King.active.where(is_black: false).first
    white_king.in_check?
  end

  # 2 tests fail if white_in_check is first, one check fails if black_in_check is first.
  # black_in_check? and white_in_check work on their own, when combined below in_check? becomes
  # no method to nil object
  # returns true if game is in check
  # def game_in_check?
  #   return true if white_in_check? || black_in_check?
  #   false
  # end

  def black_in_check?
    # identify the black king on the board
    black_king = King.active.where(is_black: true).first
    black_king.in_check?
    # calls the in_check? method in king.rb
  end

  def white_in_check?
    # identify the white kings on the board and calls on the in_check method in king.rb
    white_king = King.active.where(is_black: false).first
    white_king.in_check?
  end

end
