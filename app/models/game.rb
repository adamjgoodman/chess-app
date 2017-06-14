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

  # returns true if game is in check
  def black_in_check?(x, y)
    # identify the black kings on the board
    King.where(is_black: true, x_position: x, y_position: y)
    # selects white pieces and looks to see if
    # they have an open route to the king
    pieces.where(is_black: false).each do |piece|
      return true if piece.move_valid?(x, y)
    end
    false
  end

  def white_in_check?(x, y)
    # identify the white kings on the board
    King.where(is_black: false, x_position: x, y_position: y)
    # selects black pieces and looks to see if
    # they have an open route to the king
    pieces.where(is_black: true).each do |piece|
      return true if piece.move_valid?(x, y)
    end
    false
  end

  def black_kings_in_check?
    King.where(is_black: true).each do
      return true if black_in_check?(x, y)
    end
    false
  end

  def white_kings_in_check?(x, y)
    King.where(is_black: false).each do
      return true if white_in_check?(x, y)
    end
    false
  end

  def game_in_check?
    return true if white_kings_in_check?(x, y) || black_kings_in_check?(x, y)
    false
  end

  # game.pieces.where(is_black: is_black)
  # if moving that piece opens an unobstructed path to the king for
  # pieces.where(is_black: !is_black)
  # then you cannot move that piece because you will be placing your own king in check
  # if move!(x, y)

  # drag and drop should call valid move
  # did this move put my king in check?
end
