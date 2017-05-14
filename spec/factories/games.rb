FactoryGirl.define do
  factory :game do
    status ''
  end

  factory :available_game, class: Game do
    status 'available'
  end
end