require 'rails_helper'

RSpec.describe Piece, type: :model do
  it 'should detect horizontal obstructions' do
    game = Game.create(status: 'available')
    piece1 = Piece.create(x_position: 3, y_position: 3, game_id: game.id)
    piece2 = Piece.create(x_position: 5, y_position: 3, game_id: game.id)

    expect(piece1.path_obstructed?(7, 3)).to be true
    expect(piece2.path_obstructed?(1, 3)).to be true
  end

  it 'should detect vertical obstructions' do
    game = Game.create(active: true)
    piece1 = Piece.create(x_position: 5, y_position: 5, game_id: game.id)
    piece2 = Piece.create(x_position: 5, y_position: 3, game_id: game.id)

    expect(piece1.path_obstructed?(5, 1)).to be true
    expect(piece2.path_obstructed?(5, 7)).to be true
  end

  it 'should detect diagonal obstructions' do
    game = Game.create(active: true)
    piece1 = Piece.create(x_position: 4, y_position: 4, game_id: game.id)
    piece2 = Piece.create(x_position: 3, y_position: 3, game_id: game.id)
    piece3 = Piece.create(x_position: 5, y_position: 3, game_id: game.id)

    expect(piece1.path_obstructed?(2, 2)).to be true
    expect(piece2.path_obstructed?(5, 5)).to be true
    expect(piece1.path_obstructed?(6, 2)).to be true
    expect(piece3.path_obstructed?(3, 5)).to be true
  end

  it 'should detect path is not obstructed' do
    game = Game.create(active: true)
    piece1 = Piece.create(x_position: 4, y_position: 4, game_id: game.id)

    expect(piece1.path_obstructed?(6, 6)).to be false
    expect(piece1.path_obstructed?(4, 6)).to be false
    expect(piece1.path_obstructed?(6, 4)).to be false
  end

  it "should return opposite color of an existing piece" do
    game = Game.create(active: true)
    piece1 = Piece.create(x_position: 4, y_position: 4, game_id: game.id, is_black: true)
    piece2 = Piece.create(x_position: 5, y_position: 5, game_id: game.id, is_black: false)

    expect(piece1.opposite_color).to eq('white')
    expect(piece2.opposite_color).to eq('black')
  end
end
