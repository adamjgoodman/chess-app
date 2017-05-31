FactoryGirl.define do
  factory :game do
  end

  factory :available_game, class: Game do
    status 'available'
  end

  factory :completed_game, class: Game do
    status 'completed'
  end
end
