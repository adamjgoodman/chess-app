require 'rails_helper'

# basic one-step move
RSpec.describe Pawn, type: :model do
  it 'should move one square vertically toward opponent side of board' do
    game = Game.create(status: 'active')
    white_pawn = Pawn.create(is_black: false, x_position: 3, y_position: 1, game_id: game.id)
    black_pawn = Pawn.create(is_black: true, x_position: 3, y_position: 6, game_id: game.id)
    white_pawn2 = Pawn.create(is_black: false, x_position: 2, y_position: 6, game_id: game.id)
    black_pawn2 = Pawn.create(is_black: true, x_position: 2, y_position: 3, game_id: game.id)

    # testing a single one-step move from "home" position, then a move sideways, then a jump to far away
    expect(white_pawn.move_valid?(3, 2)).to be true
    expect(white_pawn.move_valid?(4, 1)).to be false
    expect(white_pawn.move_valid?(5, 7)).to be false

    # testing a single one-step move from "home", then backward, then a big jump
    expect(black_pawn.move_valid?(3, 5)).to be true
    expect(black_pawn.move_valid?(3, 7)).to be false
    expect(black_pawn.move_valid?(7, 3)).to be false

    # testing a move from non-home position, then a move backward, then sideways
    expect(white_pawn2.move_valid?(2, 7)).to be true
    expect(white_pawn2.move_valid?(2, 5)).to be false
    expect(white_pawn2.move_valid?(3, 6)).to be false

    # testing a move from non-home position, then backward, then sideways
    expect(black_pawn2.move_valid?(2, 2)).to be true
    expect(black_pawn2.move_valid?(2, 4)).to be false
    expect(black_pawn2.move_valid?(3, 3)).to be false
  end

  it 'should not allow a vertical move into an occupied space' do
    game = Game.create(status: 'active')
    white_pawn = Pawn.create(is_black: false, x_position: 3, y_position: 3, game_id: game.id)
    black_pawn = Pawn.create(is_black: true, x_position: 3, y_position: 4, game_id: game.id)
    white_pawn2 = Pawn.create(is_black: false, x_position: 6, y_position: 2, game_id: game.id)
    black_pawn2 = Pawn.create(is_black: true, x_position: 6, y_position: 4, game_id: game.id)
    Knight.create(is_black: false, x_position: 6, y_position: 3, game_id: game.id)

    # pawns obstructing each other's move
    expect(white_pawn.move_valid?(3, 4)).to be false
    expect(black_pawn.move_valid?(3, 3)).to be false

    # opposite color or same color piece other than pawn obstructing move
    expect(white_pawn2.move_valid?(6, 3)).to be false
    expect(black_pawn2.move_valid?(6, 3)).to be false
  end

  it 'should allow a regular diagonal capture' do
    game = Game.create(status: 'active')
    white_pawn = Pawn.create(is_black: false, x_position: 3, y_position: 3, game_id: game.id)
    black_pawn = Pawn.create(is_black: true, x_position: 4, y_position: 4, game_id: game.id)

    # Either pawn should be able to capture the other
    expect(white_pawn.move_valid?(4, 4)).to be true
    expect(black_pawn.move_valid?(3, 3)).to be true
  end

  it 'should allow white capture en passant following regular chess rules' do
    game = Game.create(status: 'active')
    white_pawn = Pawn.create(is_black: false, x_position: 4, y_position: 4, game_id: game.id)
    black_pawn = Pawn.create(is_black: true, x_position: 5, y_position: 6, game_id: game.id)
    black_pawn.move!(5, 4)

    # white pawn captures en passant to right
    expect(white_pawn.move_valid?(5, 5)).to be true
  end

  it 'should allow black capture en passant following regular chess rules' do
    game = Game.create(status: 'active')
    white_pawn2 = Pawn.create(is_black: false, x_position: 2, y_position: 1, game_id: game.id)
    black_pawn2 = Pawn.create(is_black: true, x_position: 1, y_position: 3, game_id: game.id)
    white_pawn2.move!(2, 3)
    puts "move count: #{white_pawn2.moves.count}"
    # black_pawn2 captures en passant to left
    expect(black_pawn2.move_valid?(2, 2)).to be true
  end

  it 'should not allow capture en passant if opposing pawn has moved twice' do
    game = Game.create(status: 'active')
    white_pawn3 = Pawn.create(is_black: false, x_position: 4, y_position: 4, game_id: game.id)
    black_pawn3 = Pawn.create(is_black: true, x_position: 3, y_position: 6, game_id: game.id)
    black_pawn3.move!(3, 5)
    black_pawn3.move!(3, 4)

    # white pawn tries to capture en passant a black pawn that moved twice
    expect(white_pawn3.move_valid?(3, 5)).to be false
  end
end
