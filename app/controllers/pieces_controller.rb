class PiecesController < ApplicationController
  def update
    @piece = Piece.find(params[:id])
    @game = Game.find(@piece.game_id)
    new_x = params[:x_position].to_i
    new_y = params[:y_position].to_i

    if @game.user_id_black == @piece.user_id && @piece.is_black
        @piece.move!(new_x, new_y)
        render :json => { :error => 0, :success => 1 }
    end

    if @game.user_id_white == @piece.user_id && !@piece.is_black
        @piece.move!(new_x, new_y)
        render :json => { :error => 0, :success => 1 }
    end

    render :json => { :error => 1, :success => 0 }
    
  end

  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end






