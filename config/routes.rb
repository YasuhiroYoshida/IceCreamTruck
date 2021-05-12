Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope :products, as: 'products' do
        patch 'purchase', to: 'products#purchase'
        get 'status', to: 'products#status'
        get 'status_using_ams', to: 'products#status_using_ams'
      end
    end
  end
end
