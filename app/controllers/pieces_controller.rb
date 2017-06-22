class PiecesController < ApplicationController

  def update
    @game = Game.find(params[:game_id])
    if @game.turn == @game.current_user.id
      @piece = Piece.find(params[:id])
      new_x = params[:x_position].to_i
      new_y = params[:y_position].to_i

      response = @piece.move!(new_x, new_y)

      flash[:error] = 'Invalid moves!' unless response.nil?

      render json: { error: 0, success: 1 }
    else
      flash[:error] = 'Not your move!'
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
