require 'rails_helper'

RSpec.describe Move, type: :model do
  it "should determine that player white is up" do
    FactoryGirl.create(:active_game)
    move1 = Move.create(game_id: game.id)
    move2 = Move.create(game_id: game.id)
    move3 = Move.create(game_id: game.id)
    expect(move3.turn).to eq 111
  end

  it "should determine that player black is up" do
    game = Game.create(active: true, user_id_black: 110, user_id_white: 111, index_moves_on_game_id: )
    move1 = Move.create(game_id: game.id)
    move2 = Move.create(game_id: game.id)
    move3 = Move.create(game_id: game.id)
    move4 = Move.create(game_id: game.id)
    expect(move4.turn).to eq 110
  end
end
