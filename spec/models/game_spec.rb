require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'should return available games' do
    FactoryGirl.create(:available_game)
    FactoryGirl.create(:available_game)
    FactoryGirl.create(:completed_game)
    available_games = Game.available
    expect(available_games.size).to eq 2
  end

  it 'should determine that the game is in check' do
    game = Game.create(status: 'available')
    King.active.create(is_black: true, x_position: 3, y_position: 3, game_id: game.id)
    King.active.create(is_black: false, x_position: 7, y_position: 3, game_id: game.id)
    Bishop.active.create(is_black: false, x_position: 5, y_position: 5, game_id: game.id)
    expect(game.game_in_check?).to eq true
  end

  it 'should determine that the game is not in check' do
    game = Game.create(status: 'available')
    King.active.create(is_black: true, x_position: 3, y_position: 3, game_id: game.id)
    Bishop.active.create(is_black: true, x_position: 4, y_position: 2, game_id: game.id)
    King.active.create(is_black: false, x_position: 5, y_position: 3, game_id: game.id)
    expect(game.game_in_check?).to eq true
  end

  it 'should determine that the game is not in check' do
    game = Game.create(status: 'available')
    King.active.create(is_black: false, x_position: 1, y_position: 1, game_id: game.id)
    King.active.create(is_black: true, x_position: 3, y_position: 3, game_id: game.id)
    Bishop.active.create(is_black: true, x_position: 1, y_position: 7, game_id: game.id)
    expect(game.game_in_check?).to eq false
  end
end
