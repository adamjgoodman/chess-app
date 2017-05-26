require 'rails_helper'

RSpec.describe King, type: :model do
  it 'should only move one square in any direction' do
    game = Game.create(status: 'available')
    black_king = King.create(x_position: 3, y_position: 3, game_id: game.id)

    expect(black_king.legal_move?(2, 3)).to be true
    expect(black_king.legal_move?(3, 2)).to be true
    expect(black_king.legal_move?(4, 4)).to be true
    expect(black_king.legal_move?(1, 3)).to be false
    expect(black_king.legal_move?(1, 1)).to be false
    expect(black_king.legal_move?(1, 6)).to be false
    expect(black_king.legal_move?(7, 3)).to be false
  end
end
