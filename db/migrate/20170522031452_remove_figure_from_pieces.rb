class RemoveFigureFromPieces < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :figure, :string
    remove_column :pieces, :number, :integer
  end
end
