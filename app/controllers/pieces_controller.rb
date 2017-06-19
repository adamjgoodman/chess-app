class PiecesController < ApplicationController
  def update
    @piece = Piece.find(params[:id])
    new_x = params[:x_position].to_i
    new_y = params[:y_position].to_i

    return render json: 'success' if @piece.move!(new_x, new_y)
    render json: 'failure'
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
