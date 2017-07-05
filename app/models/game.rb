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

  # rubocop:disable MethodLength
  # rubocop:disable Metrics/AbcSize

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

  def checkmate?(is_black)
    king = pieces.find_by(type: 'King', is_black: is_black)

    return false unless king.in_check?

    return false unless stalemate(is_black)

    true
  end

  # detects stalemate for color of current piece within game.
  # Runs through an array of certain color's active pieces and checks to see if there ar any valid moves available
  def stalemate(is_black)
    active_pieces = pieces_active(is_black)

    active_pieces.each do |piece|
      (0..7).each do |x|
        (0..7).each do |y|
          return false if (piece.move_valid?(x,y) && piece.move_causes_check?(x,y) == false)
          true
          
        end
      end
    end
    true
  end # returns an array of a color's active pieces

  def pieces_active(is_black)
    pieces.where('is_black = ? AND status = ?', is_black, 'active')
  end

  def game_in_check?
    white_king = pieces.where('is_black = ? AND type = ?', false, 'King').first
    black_king = pieces.where('is_black = ? AND type = ?', true, 'King').first

    return true if white_king.in_check? || black_king.in_check?
    # return true if king.in_check?
    false

  end



  def turn
    return user_id_white if moves.count.even?
    user_id_black
  end

  # rubocop:enable Metrics/AbcSize
  # rubocop:enable MethodLength
end
