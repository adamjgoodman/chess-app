class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @available_games = Game.available  
    @game = Game.new 
  end

  def create
    @game = Game.create(game_params.merge(status: 'available'))
    redirect_to game_path(@game)
  end

  def update
  	@game = Game.find(params[:id])
    @game.update_attributes(game_params.merge(status: 'active'))
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:user_id_black, :user_id_white)
  end
end
