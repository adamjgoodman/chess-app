require 'rails_helper'

RSpec.describe Knight, type: :model do 
  it 'should make a move that consists of first one step in a horizontal or vertical direction, and then one step diagonally in an outward direction' do
    white_knight_left  = FactoryGirl.create(:white_knight_left)
    white_knight_right = FactoryGirl.create(:white_knight_right)
    black_knight_left  = FactoryGirl.create(:black_knight_left)
    black_knight_right = FactoryGirl.create(:black_knight_right)
  end
end