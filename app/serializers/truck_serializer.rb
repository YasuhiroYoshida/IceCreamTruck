class TruckSerializer < ActiveModel::Serializer
  attributes :id, :name, :total_revenue
  has_many :products

  def total_revenue
    object.products.pluck(:revenue).reduce(:+)
  end
end
