require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'should return available games' do
    FactoryGirl.create(:available_game)
    FactoryGirl.create(:available_game)
    FactoryGirl.create(:completed_game)
    available_games = Game.available
    expect(available_games.size).to eq 2
  end

  it 'should determine if game is in check' do
    game = Game.create(status: 'available')
    black_king = King.create(x_position: 3, y_position: 3, game_id: game.id)

  end
end
