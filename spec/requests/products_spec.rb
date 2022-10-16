require 'rails_helper'

RSpec.describe 'ProductsController', type: :request do
  let!(:category) { create(:category) }
  let!(:product) { create(:product, category_id: category.id) }
  let!(:product1) { create(:product, category_id: category.id) }
  let!(:valid_attributes) do {
    product: {
      name: 'Phone',
      category_id: category.id,
      price: 1234,
      description: 'blaaaa'
      }
    }
  end

  let!(:invalid_attributes) do {
    product: {
      name: '1',
      price: 'cc',
      description: '  '
      }
    }
  end

  let!(:new_attributes) do {
    product: {name: 'Kettle',
      category_id: category.id,
      price: 12334,
      description: 'blaaaa2'}
    }
  end

  describe 'GET :index' do
    it 'renders a successful response' do
      get products_path

      expect(response).to be_successful
    end
  end

  describe 'GET :show' do
    it 'renders a successful response' do
      get product_path(product)

      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response.body).to include(product.name)
    end
  end

  describe 'GET :new' do
    it 'renders a successful response' do
      get new_product_path
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      get edit_product_path(product)
      expect(response).to be_successful
    end
  end

  describe 'POST :create' do
    context 'with valid parameters' do
      it 'is successfull' do
        expect do
          post products_url, params: valid_attributes
        end.to change(Product, :count).by(1)
        expect(response).to redirect_to(product_url(Product.last))
      end
    end

    context 'with invalid parameters' do
      it 'is not successfull' do
        expect do
          post products_url, params: invalid_attributes
        end.to change(Product, :count).by(0)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH :update' do
    context 'with valid parameters' do
      it 'be successful' do
        put product_url(product), params: new_attributes
        product.reload
        expect(product.name).to eq('Kettle')
        expect(response).to redirect_to(product)
        expect(flash[:notice]).to eq('Product was successfully updated.')
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        expect do
          patch product_url(product), params: invalid_attributes
        end.not_to change(product, :name)
        expect(response).to be_unprocessable
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE :destroy' do
    it 'destroys the requested product' do
      expect do
        delete product_url(product)
      end.to change(Product, :count).by(-1)
    end

    it 'redirects to the product list' do
      delete product_url(product)
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Product was successfully destroyed.')
    end

    it 'not allow to delete product that ic in the cart' do
      post add_to_cart_path(product)
      delete product_url(product)
      expect(flash[:notice]).to eq('The product cannot be removed, it is in the shopping cart.')
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST :add_to_cart' do
    it 'add product to session cart' do
      post add_to_cart_path(product)

      expect(session[:cart]).to match_array(product.id)
      expect(response).to have_http_status(:found)
    end
  end

  describe 'DELETE :remove_from_cart' do
    it 'delete product from session cart' do
      post add_to_cart_path(product)
      post add_to_cart_path(product1)
      delete remove_from_cart_path(product)

      expect(session[:cart]).not_to match_array(product.id)
      expect(session[:cart]).to match_array(product1.id)
      expect(response).to have_http_status(:found)
    end
  end
end
