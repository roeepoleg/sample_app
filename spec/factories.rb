FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person a#{n}" }
    sequence(:email) { |n| "person_a#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
end