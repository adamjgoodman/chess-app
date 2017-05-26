class PiecesController < ApplicationController
  def update
    @piece = Pieces.find(params[:id])
    new_x = params[:x].to_i
    new_y = params[:y].to_i
    @piece.move!(new_x, new_y)
  end

  def move
    @piece = Piece.find(params[:id])
    old_x = @piece.x_position
    old_y = @piece.y_position
    new_x = params[:x].to_i
    new_y = params[:y].to_i
    @piece.move = (shift from old_x, old_y to new_x, new_y)   #how do we represent this, really?
    if @piece.move.valid? 
      @piece.update_attributes { :x_position new_x, :y_position new_y }
      redirect_to game_path(@game)
    else
      return render text: 'Move not allowed.', status: :unauthorized
    end  
  end
  private

  def current_x
    #how do we get the computer to know & represent where the piece is after being dragged and dropped?
  end

  def current_x
    #how do we get the computer to know & represent where the piece is after being dragged and dropped?
  end

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
