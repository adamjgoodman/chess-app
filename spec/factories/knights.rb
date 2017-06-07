FactoryGirl.define do
  factory :knight do
  end

  factory :black_knight_left, class: Knight do
    is_black true
    x_position 1
    y_position 0
  end

  factory :black_knight_right, class: Knight do
    is_black true
    x_position 6
    y_position 0
  end

  factory :white_knight, class: Knight do
    is_black false
  end

  factory :white_knight_left, class: Knight do
    is_black false
    x_position 1
    y_position 7
  end

  factory :white_knight_right, class: Knight do
    is_black false
    x_position 6
    y_position 7
  end
end
