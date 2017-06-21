class DashboardsController < ApplicationController
  def show
    @active_games = current_user.games.where(status: 'active')
    @completed_games = current_user.games.where(status: 'completed')
  end
end
