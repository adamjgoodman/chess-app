class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.string :type
      t.boolean :black
      t.boolean :white
      t.integer :x_position
      t.integer :y_position
      t.integer :user_id
      t.integer :game_id
      t.string :status

      t.timestamps
    end
    add_index :pieces, :user_id
    add_index :pieces, :game_id
  end
end
