class StaticPagesController < ApplicationController
  def index
    @available_games = Game.available
    @game = Game.new
  end
end
