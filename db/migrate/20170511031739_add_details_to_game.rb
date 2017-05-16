class AddDetailsToGame < ActiveRecord::Migration[5.0]
  def change
      add_column :games, :active, :boolean 
      add_column :games, :status, :string
      add_column :games, :user_id_black, :integer
      add_column :games, :user_id_white, :integer
      add_column :games, :winner, :integer
      add_column :games, :game_completed, :timestamp
  end
end
