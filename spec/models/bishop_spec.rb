require 'rails_helper'

RSpec.describe Bishop, type: :model do
  it 'should only move diagonally and path not obstructed' do
    game = Game.create(status: 'available')
    bishop1 = Bishop.create(x_position: 3, y_position: 3, game_id: game.id)
    bishop2 = Bishop.create(x_position: 4, y_position: 4, game_id: game.id)

    # diagonal moves + non diagonal moves
    expect(bishop1.legal_move?(4, 4)).to be true
    expect(bishop1.legal_move?(2, 2)).to be true
    expect(bishop1.legal_move?(2, 4)).to be true
    expect(bishop1.legal_move?(4, 2)).to be true
    expect(bishop1.legal_move?(3, 1)).to be false
    expect(bishop1.legal_move?(3, 5)).to be false
    expect(bishop1.legal_move?(2, 3)).to be false

    # obstruction
    expect(bishop1.legal_move?(5, 5)).to be false
    expect(bishop2.legal_move?(2, 2)).to be false
  end

  it 'should not land on the spot with a piece of the same color' do
    game = Game.create(status: 'available')
    white_pawn = Pawn.create(black?: false, x_position: 3, y_position: 3, game_id: game.id)
    black_bishop = Bishop.create(black?: true, x_position: 1, y_position: 1, game_id: game.id)
    black_pawn = Pawn.create(black?: true, x_position: 1, y_position: 1, game_id: game.id)

    expect(black_bishop.move_valid?(3, 3)).to be true
    expect(black_bishop.move_valid?(1, 1)).to be false
  end
end
