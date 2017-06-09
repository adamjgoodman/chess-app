class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

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
  end

  def forfeit_game
    @game = Game.find(params[:id])

    if @game.user_id_black != current_user
      @game.update_attributes(status: 'complete', winner: @game.user_id_white)
    else
      @game.update_attributes(status: 'complete', winner: @game.user_id_black)
    end

    redirect_to root_path
  end

  private

  def game_params
    params.require(:game).permit(:user_id_black, :user_id_white)
  end
end
