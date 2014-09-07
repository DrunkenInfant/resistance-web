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

  factory :game do
    sequence(:id) { |n| n }
    players []
  end

end
