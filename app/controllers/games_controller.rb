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
    # redirect_to root_path
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_params.merge(status: 'active'))
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  # def create
  #   # code i used to initialize the board on my local drive
  #   @game = Game.create(active: true, status: 'available', user_id_black: 1, user_id_white: nil).initialize_board
  # end

  private

  def game_params
    params.require(:game).permit(:user_id_black, :user_id_white)
  end
end
