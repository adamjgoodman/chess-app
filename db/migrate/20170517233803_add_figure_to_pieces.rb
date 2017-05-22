class AddFigureToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :figure, :string
    add_column :pieces, :number, :integer
  end
end
