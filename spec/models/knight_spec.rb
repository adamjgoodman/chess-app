require 'rails_helper'

RSpec.describe Knight, type: :model do
  it 'knight should make a valid move' do
    game = FactoryGirl.create(:game)

    black_knight_left = FactoryGirl.create(:black_knight_left, game_id: game.id)

    expect(black_knight_left.move_valid?(0, 2)).to eq true
    expect(black_knight_left.move_valid?(2, 2)).to eq true
    expect(black_knight_left.move_valid?(3, 1)).to eq true
    expect(black_knight_left.move_valid?(1, 1)).to eq false

    black_knight_right = FactoryGirl.create(:black_knight_right, game_id: game.id)

    expect(black_knight_right.move_valid?(7, 2)).to eq true
    expect(black_knight_right.move_valid?(5, 2)).to eq true
    expect(black_knight_right.move_valid?(4, 1)).to eq true
    expect(black_knight_right.move_valid?(6, 1)).to eq false

    white_knight_left = FactoryGirl.create(:white_knight_left, game_id: game.id)

    expect(white_knight_left.move_valid?(0, 5)).to eq true
    expect(white_knight_left.move_valid?(2, 5)).to eq true
    expect(white_knight_left.move_valid?(3, 6)).to eq true
    expect(white_knight_left.move_valid?(1, 5)).to eq false

    white_knight_right = FactoryGirl.create(:white_knight_right, game_id: game.id)

    expect(white_knight_right.move_valid?(4, 6)).to eq true
    expect(white_knight_right.move_valid?(5, 5)).to eq true
    expect(white_knight_right.move_valid?(7, 5)).to eq true
    expect(white_knight_right.move_valid?(6, 5)).to eq false

    white_knight_left.update(x_position: 4, y_position: 6)

    expect(white_knight_right.move_valid?(4, 6)).to eq false
  end
end
