FactoryBot.define do
  factory :product do
    name { 'Phone' }
    description { 'MyText' }
    price { '9.99' }
  end
  # factory :invalid_product do
  #   name { '1' }
  #   description { '  ' }
  #   price { 'w' }
  # end
end
