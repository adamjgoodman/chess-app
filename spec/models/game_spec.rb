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
    black_king = King.create(is_black: true, x_position: 3, y_position: 3, game_id: game.id)
    white_queen = Queen.create(is_black: false, x_position: 5, y_position: 5, game_id: game.id)
    expect(game_in_check?).to be true
  end

  it 'should determine that the game is not in check' do
    game = Game.create(status: 'available')
    black_king = King.create(is_black: true, x_position: 3, y_position: 3, game_id: game.id)
    black_queen = Queen.create(is_black: true, x_position: 4, y_position: 3, game_id: game.id)
    white_king = King.create(is_black: false, x_position: 5, y_position: 3, game_id: game.id)
    expect(game_in_check?).to be false
  end

end
