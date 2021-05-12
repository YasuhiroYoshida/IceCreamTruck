require 'rails_helper'

RSpec.describe 'Product', type: :request do
  describe 'PATCH api/v1/products/purchase' do
    let(:products_purchase_path) { '/api/v1/products/purchase' }
    let(:truck) { create(:truck) }
    let(:params) { { truck_id: truck.id, type: nil, flavor: nil, quantity: nil } }
    context 'with valid parameters' do
      context 'when IceCream is purchased' do
        let(:flavor) { create(:flavor, truck: truck) }
        let!(:ice_cream) do
          create(:ice_cream, truck: truck, flavor: flavor, price: 100, sold: 0, remaining: 1, revenue: 0)
        end
        it 'succeeds updating the IceCream record' do
          expect(IceCream.count).to eq(1)

          patch products_purchase_path, params: params.merge({ type: ice_cream.type, flavor: flavor.name, quantity: 1 })

          expect(response).to have_http_status(:ok)
          expect(response.body).to eq('ENJOY!')
          expect(IceCream.count).to eq(1)
          expect(IceCream.first.sold).to eq(1)
          expect(IceCream.first.remaining).to eq(0)
          expect(IceCream.first.revenue).to eq(100)
          # I can go on to check every part of the models involved, but the tests will get extremely long...
        end
      end

      context 'when ShavedIce is purchased' do
        let!(:shaved_ice) do
          create(:shaved_ice, truck: truck, price: 100, sold: 0, remaining: 1, revenue: 0)
        end
        it 'succeeds updating the ShavedIce record' do
          expect(ShavedIce.count).to eq(1)

          patch products_purchase_path, params: params.merge({ type: shaved_ice.type, quantity: 1 })

          expect(response).to have_http_status(:ok)
          expect(response.body).to eq('ENJOY!')
          expect(ShavedIce.count).to eq(1)
          expect(ShavedIce.first.sold).to eq(1)
          expect(ShavedIce.first.remaining).to eq(0)
          expect(ShavedIce.first.revenue).to eq(100)
        end
      end

      context 'when SnackBar is purchased' do
        let!(:snack_bar) do
          create(:snack_bar, truck: truck, price: 100, sold: 0, remaining: 1, revenue: 0)
        end
        it 'succeeds updating the ShavedIce record' do
          expect(SnackBar.count).to eq(1)

          patch products_purchase_path, params: params.merge({ type: snack_bar.type, quantity: 1 })

          expect(response).to have_http_status(:ok)
          expect(response.body).to eq('ENJOY!')
          expect(SnackBar.count).to eq(1)
          expect(SnackBar.first.sold).to eq(1)
          expect(SnackBar.first.remaining).to eq(0)
          expect(SnackBar.first.revenue).to eq(100)
        end
      end
    end

    # From this point on, a bahavior common to all products will be tested against only one product,
    # which is IceCream, unless necesarry
    context 'with invalid parameters' do
      let(:flavor) { create(:flavor, truck: truck) }
      let!(:ice_cream) do
        create(:ice_cream, truck: truck, flavor: flavor, price: 100, sold: 0, remaining: 1, revenue: 0)
      end

      context 'when truck_id is not valid' do
        it 'fails to update the IceCream record' do
          expect(IceCream.count).to eq(1)

          patch products_purchase_path, params: params.merge({ truck_id: (truck.id + 1), type: ice_cream.type,
                                                               flavor: flavor.name, quantity: 1 })

          expect(response).to have_http_status(:not_found)
          expect(response.body).to eq('CHECK YOUR ORDER!')
          expect(IceCream.count).to eq(1)
          expect(IceCream.first.sold).to eq(0)
          expect(IceCream.first.remaining).to eq(1)
          expect(IceCream.first.revenue).to eq(0)
        end
      end

      context 'when type is not valid' do
        it 'fails to update the IceCream record' do
          expect(IceCream.count).to eq(1)

          patch products_purchase_path, params: params.merge({ type: 'WrongType', flavor: flavor.name, quantity: 1 })

          expect(response).to have_http_status(:not_found)
          expect(response.body).to eq('CHECK YOUR ORDER!')
          expect(IceCream.count).to eq(1)
          expect(IceCream.first.sold).to eq(0)
          expect(IceCream.first.remaining).to eq(1)
          expect(IceCream.first.revenue).to eq(0)
        end
      end

      context 'when flavor is not valid' do
        context 'for IceCream' do
          it 'fails to update the IceCream record' do
            expect(IceCream.count).to eq(1)

            patch products_purchase_path,
                  params: params.merge({ type: ice_cream.type, flavor: 'WrongFlavorName', quantity: 1 })

            expect(response).to have_http_status(:not_found)
            expect(response.body).to eq('CHECK YOUR ORDER!')
            expect(IceCream.count).to eq(1)
            expect(IceCream.first.sold).to eq(0)
            expect(IceCream.first.remaining).to eq(1)
            expect(IceCream.first.revenue).to eq(0)
          end
        end

        context 'for ShavedIce' do
          let!(:shaved_ice) { create(:shaved_ice, truck: truck, price: 100, sold: 0, remaining: 1, revenue: 0) }

          it 'fails to update the ShavedIce record' do
            expect(ShavedIce.count).to eq(1)

            patch products_purchase_path,
                  params: params.merge({ type: shaved_ice.type, flavor: 'UnnecessaryFlavorInfo', quantity: 1 })

            expect(response).to have_http_status(:not_found)
            expect(response.body).to eq('CHECK YOUR ORDER!')
            expect(ShavedIce.count).to eq(1)
            expect(ShavedIce.first.sold).to eq(0)
            expect(ShavedIce.first.remaining).to eq(1)
            expect(ShavedIce.first.revenue).to eq(0)
          end
        end
      end
    end

    context 'with transaction failure' do
      let(:flavor) { create(:flavor, truck: truck) }
      let!(:ice_cream) do
        create(:ice_cream, truck: truck, flavor: flavor, price: 100, sold: 0, remaining: 1, revenue: 0)
      end

      it 'fails to update the IceCream record' do
        allow_any_instance_of(IceCream).to receive(:sell!).and_raise(ActiveRecord::StatementInvalid)

        expect(IceCream.count).to eq(1)

        patch products_purchase_path, params: params.merge({ type: ice_cream.type, flavor: flavor.name, quantity: 1 })

        expect(response).to have_http_status(:internal_server_error)
        expect(response.body).to eq('TRY LATER!')
        expect(IceCream.count).to eq(1)
        expect(IceCream.first.sold).to eq(0)
        expect(IceCream.first.remaining).to eq(1)
        expect(IceCream.first.revenue).to eq(0)
      end
    end
  end

  describe 'GET api/v1/products/status' do
    let(:products_status_path) { '/api/v1/products/status' }
    before { setup_for_status }

    context 'with valid parameters' do
      it 'succeeds returning inventories and total_revenue' do
        get products_status_path, params: { truck_id: 1 }

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({
          truck_id: 1,
          inventories: [['IceCream', 'Chocolate1', 10], ['ShavedIce', nil, 11]],
          total_revenue: 1100
        }.to_json)
      end
    end

    context 'with invalid parameters' do # truck_id can't find the target truck
      it 'succeeds returning inventories and total_revenue' do
        get products_status_path, params: { truck_id: 0 }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq('NO SUCH TRUCK!')
      end
    end
  end

  describe 'GET api/v1/products/status_using_ams' do
    let(:products_status_using_ams_path) { '/api/v1/products/status_using_ams' }
    before { setup_for_status }

    context 'with valid parameters' do
      it 'succeeds returning inventories and total_revenue' do
        get products_status_using_ams_path, params: { truck_id: 1 }

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({
          data: {
            id: '1',
            type: 'trucks',
            attributes: { name: 'MyIceCreamTruck1', 'total-revenue': 1100 },
            relationships: {
              products: {
                data: [
                  { id: '100', type: 'ice-creams' },
                  { id: '1000', type: 'shaved-ices' }
                ]
              }
            }
          },
          included: [
            { id: '100',
              type: 'ice-creams',
              attributes: {
                type: 'IceCream', 'flavor-name': 'Chocolate1',
                price: 100, sold: 1, remaining: 10, revenue: 100
              },
              relationships: {
                truck: { data: { id: '1', type: 'trucks' } },
                flavor: { data: { id: '10', type: 'flavors' } }
              } },
            { id: '1000',
              type: 'shaved-ices',
              attributes: {
                type: 'ShavedIce', 'flavor-name': nil,
                price: 1000, sold: 1, remaining: 11, revenue: 1000
              },
              relationships: {
                truck: { data: { id: '1', type: 'trucks' } },
                flavor: { data: nil }
              } }
          ]
        }.to_json)
      end
    end

    context 'with invalid parameters' do
      it 'succeeds returning inventories and total_revenue' do
        get products_status_using_ams_path, params: { truck_id: 0 }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq('NO SUCH TRUCK!')
      end
    end
  end

  def setup_for_status
    # For Truck1
    truck_1 = create(:truck, id: 1, name: 'MyIceCreamTruck1')
    flavor_1 = create(:flavor, id: 10, name: 'Chocolate1', truck: truck_1)
    create(:ice_cream, id: 100, truck: truck_1, flavor: flavor_1, price: 100, sold: 1, remaining: 10, revenue: 100)
    create(:shaved_ice, id: 1000, truck: truck_1, price: 1000, sold: 1, remaining: 11, revenue: 1000)
    # For Truck2
    truck_2 = create(:truck, id: 2, name: 'MyIceCreamTruck2')
    flavor_2 = create(:flavor, id: 20, name: 'Chocolate2', truck: truck_2)
    create(:ice_cream, id: 200, truck: truck_2, flavor: flavor_2, price: 200, sold: 2, remaining: 20, revenue: 200)
    create(:shaved_ice, id: 2000, truck: truck_2, price: 2000, sold: 2, remaining: 22, revenue: 4000)
  end
end
