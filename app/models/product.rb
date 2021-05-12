class Product < ApplicationRecord
  belongs_to :truck, foreign_key: 'truck_id'
  belongs_to :flavor, optional: true

  def available?(quantity)
    (remaining - quantity) >= 0
  end

  def sell!(quantity)
    increment(:sold, quantity)
    increment(:revenue, (price * quantity))
    decrement(:remaining, quantity)
    save!
  end
end
