require 'rails_helper'

RSpec.describe Queen, type: :model do
  it 'should only move in straight lines' do
    game = Game.create(status: 'available')
    queen = Queen.create(x_position: 2, y_position: 3, game_id: game.id)
    expect(queen.move_valid?(2, 9)).to be true
    expect(queen.move_valid?(7, 3)).to be true
    expect(queen.move_valid?(4, 5)).to be true
    expect(queen.move_valid?(5, 5)).to be false
    expect(queen.move_valid?(6, 2)).to be false
    expect(queen.move_valid?(4, 7)).to be false
  end
end
