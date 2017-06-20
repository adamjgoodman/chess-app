class PiecesController < ApplicationController
  def update
    @piece = Piece.find(params[:id])
    new_x = params[:x_position].to_i
    new_y = params[:y_position].to_i

    response = @piece.move!(new_x, new_y)

    if response == false
      flash[:error] = "Invalid moves!"
    end

    render json: { error: 0, success: 1 }
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end 


