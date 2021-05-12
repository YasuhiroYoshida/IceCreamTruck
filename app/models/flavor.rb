class Flavor < ApplicationRecord
  belongs_to :truck, foreign_key: 'truck_id'
  has_many :ice_creams
  has_many :shaved_ices, inverse_of: :flavor
  has_many :snack_bars, inverse_of: :flavor

  validates :name, presence: true
  validates :truck, presence: true
end
