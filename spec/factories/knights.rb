FactoryGirl.define do
  factory :white_knight, class: Knight do 
    type "knight"
    white true
    black false
    association :game, factory: :game
  end

  factory :white_knight_left, class: Knight do
    type "knight"
    white true
    black false
    x_position 1
    y_position 7
    association :game, factory: :game
  end

  factory :white_knight_right, class: Knight do
    type "knight"
    white true
    black false
    x_position 6
    y_position 7
    association :game, factory: :game
  end

  factory :black_knight, class: Knight do
    type "knight"
    white false
    black true
    association :game, factory: :game
  end

  factory :black_knight_left, class: Knight do
    type "knight"
    white false
    black true
    x_position 1
    y_position 0
    association :game, factory: :game
  end

  factory :black_knight_right, class: Knight do
    type "knight"
    white false
    black true
    x_position 6
    y_position 0
    association :game, factory: :game
  end
end