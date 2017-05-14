require 'rails_helper'

RSpec.describe Game, type: :model do
  it "returns available games" do
    available_games = Game.available
    expect(available_games.size).to eq 2
  end
end
