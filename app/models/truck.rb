class Truck < ApplicationRecord
  has_many :products
  has_many :flavors

  validates :name, presence: true
end
