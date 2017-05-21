class GamesController < ApplicationController
  def index
    @available_games = Game.available
  end

  def show
    # code goes here
    # @game = Game.find_by(id: 6).initialize_board

  end

  # def new
  # 	@game = Game.new
  # end

  # def create
  # 	Game.create()
  # end


end
