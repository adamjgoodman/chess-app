require 'rails_helper'

RSpec.describe Rook, type: :model do
  it 'should move horizontally or vertically' do
    game = Game.create(status: 'available')
    rook = Rook.create(x_position: 2, y_position: 3, game_id: game.id)
    expect(rook.move_valid?(2, 9)).to be true
    expect(rook.move_valid?(7, 3)).to be true
  end

  it 'should not move to invalid positions' do
    game = Game.create(status: 'available')
    rook = Rook.create(x_position: 2, y_position: 3, game_id: game.id)
    expect(rook.move_valid?(3, 9)).to be false
    expect(rook.move_valid?(7, 4)).to be false
  end

  it 'should not move through another piece' do
    game = Game.create(status: 'available')
    rook = Rook.create(x_position: 2, y_position: 3, game_id: game.id)
    Rook.create(x_position: 5, y_position: 3, game_id: game.id)
    expect(rook.move_valid?(7, 3)).to be false
  end

  it 'should not move on top of a friendly piece' do
    game = Game.create(status: 'available')
    rook = Rook.create(x_position: 2, y_position: 3, game_id: game.id, is_black: false)
    Rook.create(x_position: 5, y_position: 3, game_id: game.id, is_black: false)
    expect(rook.move_valid?(5, 3)).to be false
  end

  it 'should be allowed to move on top of an opposing piece' do
    game = Game.create(status: 'available')
    rook = Rook.create(x_position: 2, y_position: 3, game_id: game.id, is_black: false)
    Rook.create(x_position: 5, y_position: 3, game_id: game.id, is_black: true)
    expect(rook.move_valid?(5, 3)).to be true
  end
end
