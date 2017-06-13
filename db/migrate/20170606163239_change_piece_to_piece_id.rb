class ChangePieceToPieceId < ActiveRecord::Migration[5.0]
  def change
    rename_column(:moves, :piece, :piece_id)
  end
end
