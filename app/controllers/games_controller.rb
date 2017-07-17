class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :update_status, only: [:show]

  def index
    @available_games = Game.available
    @game = Game.new
  end

  def create
    @game = Game.create(game_params.merge(status: 'available'))
    @game.initialize_board
    redirect_to game_path(@game)
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_params.merge(status: 'active'))
    @game.reset_piece_players
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])

    @moves = @game.moves
  end

  def forfeit_game
    @game = Game.find(params[:id])

    if @game.user_id_black == current_user.id
      @game.update_attributes(status: 'Forfeit', winner: @game.user_id_white)
    else
      @game.update_attributes(status: 'Forfeit', winner: @game.user_id_black)
    end

    redirect_to game_path(@game.id)
  end

  def update_status
    @game = Game.find(params[:id])

    if @game.checkmate?(true)
      @game.update_attributes(status: 'Checkmate', winner: @game.user_id_white)
    elsif @game.checkmate?(false)
      @game.update_attributes(status: 'Checkmate', winner: @game.user_id_black)
    elsif @game.stalemate(true) || @game.stalemate(false)
      @game.update_attributes(status: 'Stalemate', winner: 'TIED')
    end
  end

  private

  def game_params
    params.require(:game).permit(:user_id_black, :user_id_white)
  end
end
