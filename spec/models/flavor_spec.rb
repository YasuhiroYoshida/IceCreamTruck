require 'rails_helper'

RSpec.describe Flavor, type: :model do
  let(:truck) { create(:truck) }
  let(:flavor) { create(:flavor, truck: truck) }

  context 'db' do
    context 'indexes' do
      it { should have_db_index(:name) }
      it { should have_db_index(:truck_id) }
    end

    context 'columns' do
      it { should have_db_column(:name).of_type(:string).with_options(null: false) }
      it { should have_db_column(:truck_id).of_type(:integer).with_options(null: false) }
    end

    context 'foreign keys' do
      it { should belong_to(:truck).with_foreign_key('truck_id') }
    end
  end

  context 'attributes' do
    it 'has name' do
      expect(flavor).to have_attributes(name: 'Chocolate')
    end

    it 'has truck_id' do
      expect(flavor).to have_attributes(truck_id: truck.id)
    end
  end

  context 'validation' do
    it 'requires presence of name' do
      expect(flavor).to validate_presence_of(:name)
    end

    it 'requires presence of truck' do
      expect(flavor).to validate_presence_of(:truck)
    end
  end
end
