FactoryGirl.define do
=begin
	factory :user do
		name "simon"
		email "simon@example.com"
		password "password"
	end

Defining a factory example this will enable us for instance
let(:user) { FactoryGirl.create(:user) }

=end

  factory :user do
    sequence(:id) { |n| n }
    sequence(:email) { |n| "test#{n}@test.com" }
    password "jagkan"
    password_confirmation "jagkan"
  end

  factory :player do
    sequence(:id) { |n| n }
    team "resistance"
    association :user, factory: :user
    association :game, factory: :game, strategy: :build
  end

  factory :mission do
    sequence(:id) { |n| n }
    index 1
    nbr_participants 2
    nbr_fails_required 1
    association :game
  end

  factory :game do
    ignore do
      missions_count 5
      players_count 5
    end
    sequence(:id) { |n| n }
    after(:build) do |game, evaluator|
      game.players << build_list(:player, evaluator.players_count, game: game)
      game.missions << build_list(:mission, evaluator.missions_count, game: game)
    end
  end

  factory :nomination do
    association :mission
  end

  factory :vote do
  end
end
