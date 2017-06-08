require 'rails_helper'

# basic one-step move
RSpec.describe Pawn, type: :model do
  it 'should move one square vertically toward opponent side of board' do
    game = Game.create(status: 'available')
    white_pawn = Pawn.create(is_black: false, x_position: 3, y_position: 1, game_id: game.id)
    black_pawn = Pawn.create(is_black: true, x_position: 3, y_position: 6, game_id: game.id)
    white_pawn2 = Pawn.create(is_black: false, x_position: 2, y_position: 6, game_id: game.id)
    black_pawn2 = Pawn.create(is_black: true, x_position: 2, y_position: 3, game_id: game.id)

    # testing a single one-step move from "home" position, then a move sideways, then a jump to far away
    expect(white_pawn.legal_move?(3, 2)).to be true
    expect(white_pawn.legal_move?(4, 1)).to be false
    expect(white_pawn.legal_move?(5, 7)).to be false

    # testing a single one-step move from "home", then backward, then a big jump
    expect(black_pawn.legal_move?(3, 5)).to be true
    expect(black_pawn.legal_move?(3, 7)).to be false
    expect(black_pawn.legal_move?(7, 3)).to be false

    #testing a move from non-home position, then a move backward, then sideways
    expect(white_pawn2.legal_move?(2, 7)).to be true
    expect(white_pawn2.legal_move?(2, 5)).to be false
    expect(white_pawn2.legal_move?(3, 6)).to be false

    # testing a move from non-home position, then backward, then sideways
    expect(black_pawn2.legal_move?(2, 2)).to be true
    expect(black_pawn2.legal_move?(2, 4)).to be false
    expect(black_pawn2.legal_move?(3, 3)).to be false
  end

  it 'should not allow a vertical move into an occupied space' do
    game = Game.create(status: 'available')
    white_pawn = Pawn.create(is_black: false, x_position: 3, y_position: 3, game_id: game.id)
    black_pawn = Pawn.create(is_black: true, x_position: 3, y_position: 4, game_id: game.id)
    white_pawn2 = Pawn.create(is_black: false, x_position: 6, y_position: 2, game_id: game.id)
    black_pawn2 = Pawn.create(is_black: true, x_position: 6, y_position: 4, game_id: game.id)
    Knight.create(is_black: false, x_position: 6, y_position: 3, game_id: game.id)

    # pawns obstructing each other's move
    expect(white_pawn.legal_move?(3, 4)).to be false
    expect(black_pawn.legal_move?(3, 3)).to be false

    # opposite color or same color piece other than pawn obstructing move
    expect(white_pawn2.legal_move?(6, 3)).to be false
    expect(black_pawn2.legal_move?(6, 3)).to be false
  end

  it 'should allow a regular diagonal capture' do
    game = Game.create(status: 'available')
    white_pawn = Pawn.create(is_black: false, x_position: 3, y_position: 3, game_id: game.id, piece_id: id)
    black_pawn = Pawn.create(is_black: true, x_position: 4, y_position: 4, game_id: game.id), piece_id: id)

    # Either pawn should be able to capture the other
    expect(white_pawn2.legal_move?(4, 4)).to be true
    expect(black_pawn2.legal_move?(3, 3)).to be true
  end
end
