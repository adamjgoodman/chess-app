class GamesController < ApplicationController
  def index
    @available_games = Game.available
  end

  def show
  end
end
