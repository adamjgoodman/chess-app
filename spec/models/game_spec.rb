require 'rails_helper'

RSpec.describe Game, type: :model do
  it "should returns available games" do
    FactoryGirl.create(:available_game)
    FactoryGirl.create(:completed_game)
    available_games = Game.available
    expect(available_games.size).to eq 1
  end
end
