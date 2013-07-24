FactoryGirl.define do
	factory :user do
		email "example@example.com"
		password "password"
		password_confirmation "password"
	end

	factory :task do
		description "grab milk"
		user
	end
end