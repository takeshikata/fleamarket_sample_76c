FactoryBot.define do

  factory :product do
    association :user
    # association :image
    association :category
    association :product_condition
    association :preparation_term
    association :shipping_region
    # user
    name                 {"testtesttest"}
    introduction         {"test"}
    price                {"888"}
    # category
    # product_condition
    # shipping_region
    # preparation_term
    # purchaser_id         {"1"}
    created_at           {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now)}
    updated_at           {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now)}
    # brand_id             {"1"}
    # shipping_payer_id    {"1"}
  end

end
