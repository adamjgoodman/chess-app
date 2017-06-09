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

  it 'should be able to castle following chess rules' do
    game = Game.create(status: 'available')
    black_king = King.create(x_position: 4, y_position: 7, game_id: game.id)
    white_king = King.create(x_position: 4, y_position: 0, game_id: game.id)
    Rook.create(x_position: 7, y_position: 7, game_id: game.id)
    Rook.create(x_position: 0, y_position: 0, game_id: game.id)

    expect(black_king.legal_move?(6, 7)).to be true
    expect(white_king.legal_move?(2, 0)).to be true
  end
end
