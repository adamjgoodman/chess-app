class CreateMoves < ActiveRecord::Migration[5.0]
  def change
    create_table :moves do |t|
        t.integer :game_id
        t.integer :piece
        t.integer :destination_x
        t.integer :destination_y
        t.integer :other_piece_id
        t.string :action
        t.boolean :check
        t.timestamps
    end
    add_index :moves, :game_id
    add_index :moves, :piece
  end
end
