class PiecesController < ApplicationController
  def update
    @piece = Piece.find(params[:id])
    new_x = params[:x_position].to_i
    new_y = params[:y_position].to_i
    render json: { error: 0, success: 1 } if @piece.move!(new_x, new_y)
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
