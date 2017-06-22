FactoryGirl.define do
  factory :game do
  end

  factory :available_game, class: Game do
    status 'available'
  end

  factory :completed_game, class: Game do
    status 'completed'
  end

  factory :active_game, class: Game do
    active true
    user_id_black 110
    user_id_white 111
  end
end
