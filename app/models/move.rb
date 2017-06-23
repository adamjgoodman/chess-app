class Move < ApplicationRecord
  belongs_to :game
  belongs_to :piece

  def algebra_x
    %w[a b c d e f g h][destination_x]
  end

  def algebra_y
    destination_y + 1
  end

  def destination
    "#{algebra_x} #{algebra_y}"
  end

  # rubocop:disable MethodLength
  # rubocop: disable CyclomaticComplexity
  def to_algebra
    case action
    when 'castles kingside'
      'O-O'

    when 'castles queenside'
      'O-O-O'

    when 'captures piece'
      "#{destination} &#x2020;"

    when 'promotes pawn'
      "#{destination} promotes"

    when 'captures en passant'
      "#{destination} ep&#x2020;"

    else
      check ? "#{destination} check" : destination
    end
  end
  # rubocop: enable CyclomaticComplexity
  # rubocop:enable MethodLength
end
