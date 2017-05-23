class GamesController < ApplicationController
  def index
    @available_games = Game.available
  end

  def show
    @game = Game.find_by(id:15)
  end

  def new
  	@game = Game.new
  end

  def create
    @game = Game.create(active: true, status: 'available', user_id_black: 1, user_id_white: 2).initialize_board
  	# @game = Game.create(game_params)
 end

 private

 # def game_params
 #  params.require(:game).permit(:active, :status, :user_id_black, :user_id_white)
 #  end
end

