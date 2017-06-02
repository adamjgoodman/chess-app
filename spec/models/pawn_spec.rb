require 'rails_helper'

# basic one-step move
RSpec.describe Pawn, type: :model do
  it 'should move one square vertically toward opponent side of board' do
    game = Game.create(status: 'available')
    white_pawn = Pawn.create(is_black: false, x_position: 3, y_position: 1, game_id: game.id)
    black_pawn = Pawn.create(is_black: true, x_position: 3, y_position: 6, game_id: game.id)
    white_pawn2 = Pawn.create(is_black: false, x_position: 2, y_position: 6, game_id: game.id)
    black_pawn2 = Pawn.create(is_black: true, x_position: 2, y_position: 3, game_id: game.id)

    expect(white_pawn.legal_move?(3, 2)).to be true
    expect(white_pawn.legal_move?(4, 2)).to be false
    expect(white_pawn.legal_move?(5, 7)).to be false

    expect(black_pawn.legal_move?(3, 5)).to be true
    expect(black_pawn.legal_move?(2, 6)).to be false
    expect(black_pawn.legal_move?(7, 3)).to be false

    expect(white_pawn2.legal_move?(2, 7)).to be true
    expect(white_pawn2.legal_move?(2, 5)).to be false
    expect(white_pawn2.legal_move?(3, 6)).to be false

    expect(black_pawn2.legal_move?(2, 2)).to be true
    expect(black_pawn2.legal_move?(2, 4)).to be false
    expect(black_pawn2.legal_move?(3, 3)).to be false
  end
end
