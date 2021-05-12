class Api::V1::ProductsController < ApplicationController
  attr_reader :type, :flavor, :truck_id, :quantity, :product

  before_action :set_attrs
  before_action :validate_order, :set_product, :check_availability, only: :purchase
  before_action :validate_inquiry, only: %i[status status_using_ams]

  def purchase
    ActiveRecord::Base.transaction do
      product.sell!(quantity)
    end
    render json: 'ENJOY!', status: :ok
  rescue StandardError
    render json: 'TRY LATER!', status: :internal_server_error
  end

  def status
    inventories = Product.includes(:flavor).where(truck_id: truck_id).pluck('products.type, flavors.name, products.remaining')
    total_revenue = Product.where(truck_id: truck_id).pluck(:revenue).reduce(:+)
    render json: { truck_id: truck_id, inventories: inventories, total_revenue: total_revenue }, status: :ok
  end

  # Using active_model_serializer following JSON:API specs
  def status_using_ams
    render json: Truck.find(truck_id), include: [:products]
  end

  private

  def product_params
    params.permit(:type, :flavor, :truck_id, :quantity)
  end

  def set_attrs
    @type = product_params['type']
    @flavor = product_params['flavor'].present? ? product_params['flavor'] : nil
    @truck_id = product_params['truck_id'].to_i
    @quantity = product_params['quantity'].to_i
  end

  def validate_order
    unless Object.const_defined?(type) && valid_quantity? && valid_truck?
      render json: 'CHECK YOUR ORDER!', status: :not_found and return
    end
  end

  def valid_quantity?
    quantity.positive?
  end

  def valid_truck?
    Truck.exists?(truck_id)
  end

  def set_product
    @product = type.constantize.includes(:flavor).where(truck_id: truck_id, 'flavor.name': flavor).first
  end

  def check_availability
    render json: 'CHECK YOUR ORDER!', status: :not_found and return unless product
    render json: 'SO SORRY!', status: :ok and return unless product.available?(quantity)
  end

  def validate_inquiry
    render json: 'NO SUCH TRUCK!', status: :not_found and return unless valid_truck?
  end
end
