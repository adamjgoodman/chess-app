FactoryGirl.define do
  factory :knight do 
    type "knight"
  end

  factory :black_knight_left, class: Knight do
    type "knight"
    black true
    white false
    x_position 1
    y_position 0
  end

  factory :white_knight, class: Knight do 
    type "knight"
    white true
    black false
  end

  factory :white_knight_left, class: Knight do 
    type "knight"
    white true
    black false
  end

end