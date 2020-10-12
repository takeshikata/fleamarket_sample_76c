FactoryBot.define do

  factory :product do
    association :user
    # association :image
    association :category
    association :product_condition
    association :preparation_term
    association :shipping_region
    name                 {"testtesttest"}
    introduction         {"test"}
    price                {"888"}
    created_at           {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now)}
    updated_at           {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now)}
  end

end
