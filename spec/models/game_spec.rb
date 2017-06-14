require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'should return available games' do
    FactoryGirl.create(:available_game)
    FactoryGirl.create(:available_game)
    FactoryGirl.create(:completed_game)
    available_games = Game.available
    expect(available_games.size).to eq 2
  end

  it 'should detect King in checkmate' do
  	game = Game.create
  	black_King = King.create(is_black: true, x_position: 4, y_position: 5, game_id: game.id, status: 'active')
  	white_queen = Queen.create(is_black: false, x_position: 4, y_position: 6, game_id: game.id, status: 'active')
  	white_queen2 = Queen.create(is_black: false, x_position: 3, y_position: 6, game_id: game.id, status: 'active')

  	expect(game.checkmate(black_King.is_black)).to eq true
  end

  it 'should detect King is NOT in checkmate' do
  	game = Game.create
  	black_King = King.create(is_black: true, x_position: 4, y_position: 5, game_id: game.id, status: 'active')
  	white_queen = Queen.create(is_black: false, x_position: 4, y_position: 6, game_id: game.id, status: 'active')

  	expect(game.checkmate(black_King.is_black)).to eq false
  end

end


