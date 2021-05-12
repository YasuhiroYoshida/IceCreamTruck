require 'rails_helper'

RSpec.describe Truck, type: :model do
  let(:truck) { create(:truck) }

  context 'db' do
    context 'indices' do
    end

    context 'columns' do
      it { should have_db_column(:name).of_type(:string).with_options(null: false) }
    end
  end

  context 'attributes' do
    it 'has name' do
      expect(truck).to have_attributes(name: 'MyIceCreamTruck')
    end
  end

  context 'validation' do
    it 'requires presence of name' do
      expect(truck).to validate_presence_of(:name)
    end
  end
end
