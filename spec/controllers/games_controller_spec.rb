require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'games#index action' do
    it 'should successfully show games page' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'games#create action' do
    it 'should successfully create a new game in our database' do
      post :create, params: { game: { user_id_black: 15 } }
      game = Game.last
      expect(response).to redirect_to game_path[game.id]  
      expect(game.user_id_black).to eq(15)
    end
  end
end
	