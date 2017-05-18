require 'rails_helper'

RSpec.describe Piece, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

RSpec.describe Piece, type: :model do
it "should detect horizontal obstructions" do
  game = Game.create(active: true)
  piece_1 = Piece.create(x_position: 3, y_position: 3, game_id: game.id)
  piece_2 = Piece.create(x_position: 5, y_position: 3, game_id: game.id)

  expect(piece_1.is_obstructed?(7, 3)).to be true
  expect(piece_2.is_obstructed?(1, 3)).to be true
end

it "should detect vertical obstructions" do
  game = Game.create(active: true)
  piece_1 = Piece.create(x_position: 5, y_position: 5, game_id: game.id)
  piece_2 = Piece.create(x_position: 5, y_position: 3, game_id: game.id)

  expect(piece_1.is_obstructed?(5, 1)).to be true
  expect(piece_2.is_obstructed?(5,7)).to be true
end

it "should detect diagonal obstructions" do
  game = Game.create(active: true)
  piece_1 = Piece.create(x_position: 4, y_position: 4, game_id: game.id)
  piece_2 = Piece.create(x_position: 3, y_position: 3, game_id: game.id)
  piece_3 = Piece.create(x_position: 5, y_position: 3, game_id: game.id)

  expect(piece_1.is_obstructed?(2,2)).to be true
  expect(piece_2.is_obstructed?(5,5)).to be true
  expect(piece_1.is_obstructed?(6,2)).to be true
  expect(piece_3.is_obstructed?(3,5)).to be true

end	

end
