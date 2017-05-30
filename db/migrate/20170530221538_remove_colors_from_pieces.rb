class RemoveColorsFromPieces < ActiveRecord::Migration[5.0]
  def change
  	remove_column :pieces, :black, :boolean
  	remove_column :pieces, :white, :boolean
  	add_column :pieces, :black?, :boolean
  end
end
