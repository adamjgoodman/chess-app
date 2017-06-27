class PiecesController < ApplicationController
  def update
    @piece = Piece.find(params[:id])
    new_x = params[:x_position].to_i
    new_y = params[:y_position].to_i

    if @piece.user_id != current_user.id
      flash[:error] = 'Invalid move, not your piece. Try another move.'
    elsif @piece.move?(new_x, new_y)
      render json: { success: true }
    else
      flash[:error] = 'Move is invalid. Try another move.'
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
