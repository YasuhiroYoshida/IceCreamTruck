require 'rails_helper'

RSpec.describe IceCream, type: :model do
  let(:truck) { create(:truck) }
  let(:flavor) { create(:flavor, truck: truck) }
  let(:ice_cream) { create(:ice_cream, truck: truck, flavor: flavor) }

  context 'attributes' do
    it 'has type' do
      expect(ice_cream).to have_attributes(type: 'IceCream')
    end

    it 'has truck' do
      expect(ice_cream).to have_attributes(truck: truck)
    end

    it 'has flavor' do
      expect(ice_cream).to have_attributes(flavor: flavor)
    end
    it 'has price' do
      expect(ice_cream).to have_attributes(price: 100)
    end
    it 'has sold' do
      expect(ice_cream).to have_attributes(sold: 0)
    end
    it 'has remaining' do
      expect(ice_cream).to have_attributes(remaining: 1)
    end
    it 'has revenue' do
      expect(ice_cream).to have_attributes(revenue: 0)
    end
  end

  context 'validation' do
    it 'requires presence of name' do
      expect(ice_cream).to validate_presence_of(:type)
    end

    it 'requires presence of truck' do
      expect(ice_cream).to validate_presence_of(:truck)
    end

    it 'requires presence of flavor' do
      expect(ice_cream).to validate_presence_of(:flavor)
    end

    it 'requires presence of price' do
      expect(ice_cream).to validate_presence_of(:price)
    end

    it 'requires presence of sold' do
      expect(ice_cream).to validate_presence_of(:sold)
    end

    it 'requires presence of remaining' do
      expect(ice_cream).to validate_presence_of(:remaining)
    end

    it 'requires presence of revenue' do
      expect(ice_cream).to validate_presence_of(:revenue)
    end

    it 'requires numericality and greater_than_or_equal_to of price' do
      expect(ice_cream).to validate_numericality_of(:price).is_greater_than_or_equal_to(0)
    end

    it 'requires numericality and greater_than_or_equal_to of price' do
      expect(ice_cream).to validate_numericality_of(:sold).is_greater_than_or_equal_to(0)
    end

    it 'requires numericality and greater_than_or_equal_to of price' do
      expect(ice_cream).to validate_numericality_of(:remaining).is_greater_than_or_equal_to(0)
    end
    it 'requires numericality and greater_than_or_equal_to of price' do
      expect(ice_cream).to validate_numericality_of(:revenue).is_greater_than_or_equal_to(0)
    end
  end

  describe '#available?' do
    context 'when (remaining - quantity) is greater than or equal to 0' do
      it 'returns true' do
        expect(ice_cream.available?(1)).to be_truthy
      end
    end
    context 'when (remaining - quantity) is not greater than or equal to 0' do
      it 'returns false' do
        expect(ice_cream.available?(2)).to be_falsey
      end
    end
  end

  describe '#sell!' do
    context 'when (remaining - quantity) is greater than or equal to 0' do
      it 'returns true' do
        expect(ice_cream.sell!(1)).to be_truthy
      end
    end
    context 'when (remaining - quantity) is not greater than or equal to 0' do
      it 'returns false' do
        expect { ice_cream.sell!(2) }.to raise_error
      end
    end
  end
end
