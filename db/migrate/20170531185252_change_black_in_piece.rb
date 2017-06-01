class ChangeBlackInPiece < ActiveRecord::Migration[5.0]
  def change
  	rename_column :pieces, :black?, :is_black
  end
end
