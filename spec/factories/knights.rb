FactoryGirl.define do
  factory :white_knight, class: Knight do 
    type "knight"
    white true
    black false
    association :game, factory: :game
  end
end