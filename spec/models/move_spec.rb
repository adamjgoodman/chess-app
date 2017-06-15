require 'rails_helper'

RSpec.describe Move, type: :model do
  it 'should promote a Pawn to Queen when the pawn moves to the last row' do
    game = Game.create(active: true)
    white_pawn = Pawn.create(is_black: false, x_position: 4, y_position: 6, game_id: game.id)
    black_pawn = Pawn.create(is_black: true, x_position: 3, y_position: 1, game_id: game.id)
    white_pawn.move!(4, 7)
    black_pawn.move!(3, 0)

    expect(game.pieces.where(x_position: 4, y_position: 7).first.type).to eq 'Queen'
    expect(game.pieces.where(x_position: 3, y_position: 0).first.type).to eq 'Queen'
  end

  # it 'should return the user_id of the current turn'
  #   game = Game.create(active: true)

  # end
end
