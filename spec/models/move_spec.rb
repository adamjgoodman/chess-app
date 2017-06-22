require 'rails_helper'

RSpec.describe Move, type: :model do

  it 'should promote a Pawn to Queen and update move action when the pawn is promoted' do
    game = Game.create(active: true)
    white_pawn = Pawn.create(is_black: false, x_position: 4, y_position: 6, game_id: game.id)
    black_pawn = Pawn.create(is_black: true, x_position: 3, y_position: 1, game_id: game.id)
    white_pawn.move!(4, 7)
    black_pawn.move!(3, 0)

    expect(game.pieces.where(x_position: 4, y_position: 7).first.type).to eq 'Queen'
    expect(game.pieces.where(x_position: 3, y_position: 0).first.type).to eq 'Queen'
  end

  it 'should update move to show action == promotes pawn when the pawn moves to the last row' do
    game = Game.create(active: true)
    white_pawn = Pawn.create(is_black: false, x_position: 4, y_position: 6, game_id: game.id)
    black_pawn = Pawn.create(is_black: true, x_position: 3, y_position: 1, game_id: game.id)
    white_pawn.move!(4, 7)
    black_pawn.move!(3, 0)

    expect(game.moves.last.action).to eq 'promotes pawn'
  end

  it 'should update attributes of move to show action == castles if player castles' do
    game = Game.create(active: true)
    white_king = King.create(is_black: false, x_position: 4, y_position: 0, game_id: game.id)
    Rook.create(is_black: false, x_position: 0, y_position: 0, game_id: game.id)
    white_king.move!(2, 0)

    expect(game.moves.last.action).to eq 'castles queenside'
  end

  it 'should update the location of the relevant rook if a player castles' do
    game = Game.create(active: true)
    white_king = King.create(is_black: false, x_position: 4, y_position: 0, game_id: game.id)
    white_rook = Rook.create(is_black: false, x_position: 7, y_position: 0, game_id: game.id)
    white_king.move!(6, 0)
    white_rook.reload

    expect(game.moves.last.action).to eq 'castles kingside'
    expect(white_rook.x_position).to eq 5
    expect(white_rook.y_position).to eq 0
  end

  it 'should NOT update the location of the WRONG rook if a player castles' do
    game = Game.create(active: true)
    white_king = King.create(is_black: false, x_position: 4, y_position: 0, game_id: game.id)
    Rook.create(is_black: false, x_position: 7, y_position: 0, game_id: game.id)
    white_rook_queenside = Rook.create(is_black: false, x_position: 0, y_position: 0, game_id: game.id)
    white_king.move!(6, 0)
    white_rook_queenside.reload

    expect(game.moves.last.action).to eq 'castles kingside'
    expect(white_rook_queenside.x_position).to eq 0
    expect(white_rook_queenside.y_position).to eq 0
  end

  it 'should update the attributes of a moved piece' do
    game = Game.create(active: true)
    white_knight = Knight.create(is_black: false, x_position: 6, y_position: 0, game_id: game.id)
    white_knight.move!(5, 2)
    white_knight.reload

    expect(white_knight.x_position).to eq 5
    expect(white_knight.y_position).to eq 2
  end

  it 'should update the location and status of a captured piece' do
    game = Game.create(active: true)
    white_knight = Knight.create(is_black: false, x_position: 5, y_position: 2, game_id: game.id)
    black_pawn = Pawn.create(is_black: true, x_position: 4, y_position: 3, game_id: game.id)
    black_pawn.move!(5, 2)
    white_knight.reload

    expect(white_knight.x_position).to eq 8
    expect(white_knight.y_position).to eq 8
    expect(white_knight.status).to eq 'captured'
  end

  it 'should update the attributes of the opposing pawn if white_capture_en_passant' do
    game = Game.create(status: 'active')
    white_pawn = Pawn.create(is_black: false, x_position: 4, y_position: 4, game_id: game.id)
    black_pawn = Pawn.create(is_black: true, x_position: 5, y_position: 6, game_id: game.id)
    black_pawn.move!(5, 4)
    white_pawn.move!(5, 5)
    black_pawn.reload

    # white pawn captures en passant to right
    expect(black_pawn.x_position).to eq 8
    expect(black_pawn.y_position).to eq 8
    expect(black_pawn.status).to eq 'captured'
  end

  it 'should update attributes of move to show action == captures en passant if white_capture_en_passant' do
    game = Game.create(status: 'active')
    white_pawn = Pawn.create(is_black: false, x_position: 4, y_position: 4, game_id: game.id)
    black_pawn = Pawn.create(is_black: true, x_position: 5, y_position: 6, game_id: game.id)
    black_pawn.move!(5, 4)
    white_pawn.move!(5, 5)

    # white pawn captures en passant to right
    expect(game.moves.last.action).to eq 'captures en passant'
  end
end
