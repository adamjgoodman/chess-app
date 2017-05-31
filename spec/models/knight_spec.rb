require 'rails_helper'

RSpec.describe Knight, type: :model do 
  it 'should make a move that consists of first one step in a horizontal or vertical direction, and then one step diagonally in an outward direction' do
    game   = FactoryGirl.build(:game)
    
    black_knight_left = FactoryGirl.build(:black_knight_left)

    expect(black_knight_left.move_valid?(0,2)).to eq true
    expect(black_knight_left.move_valid?(2,2)).to eq true
    expect(black_knight_left.move_valid?(3,1)).to eq true
    expect(black_knight_left.move_valid?(1,1)).to eq false

  end
end