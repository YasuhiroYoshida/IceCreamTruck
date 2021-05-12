class ProductSerializer < ActiveModel::Serializer
  attributes :id, :type, :flavor_name, :price, :sold, :remaining, :revenue
  belongs_to :truck
  belongs_to :flavor, optinal: true

  def type
    object.type
  end

  def flavor_name
    object&.flavor&.name
  end
end
