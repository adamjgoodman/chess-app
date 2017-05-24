require 'rails_helper'

RSpec.describe King, type: :model do
it 'should only move one square in any direction' do
    game = Game.create(status: 'available')
    Black_King = King.create(x_position: 3, y_position: 3, game_id: game.id)

    expect(Black_King.legal_move?(7, 3)).to be false
    expect(Black_King.legal_move?(2, 3)).to be true
    expect(Black_King.legal_move?(1, 3)).to be false
    expect(Black_King.legal_move?(1, 1)).to be false
    expect(Black_King.legal_move?(1, 6)).to be false
    expect(Black_King.legal_move?(3, 2)).to be true
  end


  it 'should detect when path is obstructed' do
     game = Game.create(active: true)
     Black_King = King.create(x_position: 3, y_position: 3, game_id: game.id, black: true)
     piece1 = Piece.create(x_position: 2, y_position: 3, game_id: game.id)
     piece2 = Piece.create(x_position: 3, y_position: 2, game_id: game.id)

     expect(Black_King.path_obstructed?(3, 4)).to be false
     expect(Black_King.path_obstructed?(3, 2)).to be true
     expect(Black_King.path_obstructed?(2, 3)).to be true
     expect(Black_King.path_obstructed?(2, 2)).to be false
  end

end
