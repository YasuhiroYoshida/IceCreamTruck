require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'db' do
    context 'indexes' do
      it { should have_db_index(:truck_id) }
      it { should have_db_index(%i[id type]) }
      it { should have_db_index(:flavor_id) }
    end

    context 'columns' do
      it { should have_db_column(:type).of_type(:string).with_options(null: true) }
      it { should have_db_column(:flavor_id).of_type(:integer).with_options(null: true) }
      it { should have_db_column(:price).of_type(:integer).with_options(null: false, default: 0) }
      it { should have_db_column(:sold).of_type(:integer).with_options(null: false, default: 0) }
      it { should have_db_column(:remaining).of_type(:integer).with_options(null: false, default: 0) }
      it { should have_db_column(:revenue).of_type(:integer).with_options(null: false, default: 0) }
      it { should have_db_column(:truck_id).of_type(:integer).with_options(null: false) }
    end

    context 'foreign keys' do
      it { should belong_to(:truck).with_foreign_key('truck_id') }
      # Skipping the test for the foreign key on flabors table as it is "optional"
    end
  end
end
