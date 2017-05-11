class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.boolean :active
      t.string :status
      t.integer :user_id_black
      t.integer :user_id_white
      t.integer :winner
      t.timestamps :game_begun
      t.timestamps :game_completed
    end
  end
end
