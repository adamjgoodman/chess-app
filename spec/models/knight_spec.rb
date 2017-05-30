require 'rails_helper'

RSpec.describe Knight, type: :model do 
  it 'should make a move that consists of first one step in a horizontal or vertical direction, and then one step diagonally in an outward direction' do
    game = FactoryGirl.create(:game)
  end
end