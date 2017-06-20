require 'rails_helper'

RSpec.describe Move, type: :model do
  it "should determine that it is player black's turn" do
    game = Game.create(status: 'available', user_id_black: 12, user_id_white: 13)
    game.moves.count == 31
    expect(game.moves.turn).to eq 12
  end
end
