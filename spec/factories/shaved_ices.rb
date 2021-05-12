FactoryBot.define do
  factory :shaved_ice do
    type { 'ShavedIce' }
    flavor_id {}
    price { 100 }
    sold { 0 }
    remaining { 1 }
    revenue { 0 }
    truck_id {}
  end
end
