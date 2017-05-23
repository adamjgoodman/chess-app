class PiecesController < ApplicationController
  def update
    @piece = Pieces.find(params[:id])
    new_x = params[:x].to_i
    new_y = params[:y].to_i
    return update_attributes(x_position: new_x, y_position: new_y) if @piece.move!(new_x, new_y)
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
