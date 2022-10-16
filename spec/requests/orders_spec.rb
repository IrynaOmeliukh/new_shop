require 'rails_helper'

RSpec.describe 'OrdersController', type: :request do
  let!(:order) { create(:order) }
  let!(:product) { create(:product) }
  let!(:valid_params) do
    {
      first_name: 'Iryna',
      last_name: 'Om',
      address: 'Books',
      phone: '5435345',
      product_ids: [product.id]
    }
  end
  let!(:invalid_params) { { order: { first_name: '' } } }

  describe 'GET :index' do
    it 'returns http success' do
      get orders_path

      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST :create' do
    it 'creates success' do
      expect do
        post orders_url, params: valid_params
      end.to change(Order, :count).by(1)

      expect(response).to have_http_status(:found)
    end

    it 'creation failed' do
      expect do
        post orders_url, params: invalid_params
      end.to change(Order, :count).by(0)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
