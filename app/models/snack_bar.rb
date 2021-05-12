class SnackBar < Product
  belongs_to :truck, foreign_key: 'truck_id'
  belongs_to :flavor, optional: true

  validates :type, presence: true, format: { with: /\ASnackBar\z/ }
  validates :truck, presence: true
  validates :flavor, absence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :sold, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :remaining, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :revenue, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
