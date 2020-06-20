FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(min_length: 6)
    nickname {Faker::Name.name}
    email {Faker::Internet.email}
    password {password}
    password_confirmation {password}
  end
end
