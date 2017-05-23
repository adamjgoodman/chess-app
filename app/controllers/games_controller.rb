class GamesController < ApplicationController
  def index
    @available_games = Game.available
  end

  def show
    # code to get the board on my page. 24 is the game id that had all my pieces so I hardcoded it
    @game = Game.find_by(id: 24)
  end

  def new
    @game = Game.new
  end

  def create
    # code i used to initialize the board on my local drive
    @game = Game.create(active: true, status: 'available', user_id_black: 1, user_id_white: 2).initialize_board
  end
end
