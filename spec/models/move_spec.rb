require 'rails_helper'

RSpec.describe Move, type: :model do
  it "should determine that it is player white's turn" do
    game = Game.create(status: 'available', user_id_black: 12, user_id_white: 13)
    move = Move.create(game_id: game.id)
    game.moves.count == 9
    expect(move.turn).to eq 13
  end

  it "should determine that it is player black's turn" do
    game = Game.create(status: 'available', user_id_black: 12, user_id_white: 13)
    move = Move.create(game_id: game.id)
    game.moves.count == 8
    expect(move.turn).to eq 12
  end
end
