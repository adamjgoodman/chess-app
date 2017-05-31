class GamesController < ApplicationController
  def index
    @available_games = Game.available
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    # code i used to initialize the board on my local drive
    @game = Game.create(active: true, status: 'available', user_id_black: 1, user_id_white: 2).initialize_board
  end
end
