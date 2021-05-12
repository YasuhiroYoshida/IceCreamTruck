FactoryBot.define do
  factory :product do
    type {}
    flavor_id {}
    price { 100 }
    sold { 0 }
    remaining { 1 }
    revenue { 0 }
    truck_id {}
  end
end
