require 'rails_helper'

RSpec.describe 'ProductsController', type: :request do
  let!(:category) { create(:category) }
  let!(:product) { create(:product, category_id: category.id) }
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
        # expect(response).to redirect_to(products_path)
        # expect(flash[:notice]).to eq('Product was successfully updated.')
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
    it 'destroys the requested category' do
      expect do
        delete product_url(product)
      end.to change(Product, :count).by(-1)
    end

    it 'redirects to the category list' do
      delete product_url(product)
      expect(response).to redirect_to(products_url)
      expect(flash[:notice]).to eq('Product was successfully destroyed.')
    end
  end
end

# # This spec was generated by rspec-rails when you ran the scaffold generator.
# # It demonstrates how one might use RSpec to test the controller code that
# # was generated by Rails when you ran the scaffold generator.
# #
# # It assumes that the implementation code is generated by the rails scaffold
# # generator. If you are using any extension libraries to generate different
# # controller code, this generated spec may or may not pass.
# #
# # It only uses APIs available in rails and/or rspec-rails. There are a number
# # of tools you can use to make these specs even more expressive, but we're
# # sticking to rails and rspec-rails APIs to keep things simple and stable.

# RSpec.describe "/products", type: :request do

#   # This should return the minimal set of attributes required to create a valid
#   # Product. As you add validations to Product, be sure to
#   # adjust the attributes here as well.
#   let(:valid_attributes) {
#     skip("Add a hash of attributes valid for your model")
#   }

#   let(:invalid_attributes) {
#     skip("Add a hash of attributes invalid for your model")
#   }

#   describe "GET /index" do
#     it "renders a successful response" do
#       Product.create! valid_attributes
#       get products_url
#       expect(response).to be_successful
#     end
#   end

#   describe "GET /show" do
#     it "renders a successful response" do
#       product = Product.create! valid_attributes
#       get product_url(product)
#       expect(response).to be_successful
#     end
#   end

#   describe "GET /new" do
#     it "renders a successful response" do
#       get new_product_url
#       expect(response).to be_successful
#     end
#   end

#   describe "GET /edit" do
#     it "renders a successful response" do
#       product = Product.create! valid_attributes
#       get edit_product_url(product)
#       expect(response).to be_successful
#     end
#   end

#   describe "POST /create" do
#     context "with valid parameters" do
#       it "creates a new Product" do
#         expect {
#           post products_url, params: { product: valid_attributes }
#         }.to change(Product, :count).by(1)
#       end

#       it "redirects to the created product" do
#         post products_url, params: { product: valid_attributes }
#         expect(response).to redirect_to(product_url(Product.last))
#       end
#     end

#     context "with invalid parameters" do
#       it "does not create a new Product" do
#         expect {
#           post products_url, params: { product: invalid_attributes }
#         }.to change(Product, :count).by(0)
#       end

#       it "renders a successful response (i.e. to display the 'new' template)" do
#         post products_url, params: { product: invalid_attributes }
#         expect(response).to be_successful
#       end
#     end
#   end

#   describe "PATCH /update" do
#     context "with valid parameters" do
#       let(:new_attributes) {
#         skip("Add a hash of attributes valid for your model")
#       }

#       it "updates the requested product" do
#         product = Product.create! valid_attributes
#         patch product_url(product), params: { product: new_attributes }
#         product.reload
#         skip("Add assertions for updated state")
#       end

#       it "redirects to the product" do
#         product = Product.create! valid_attributes
#         patch product_url(product), params: { product: new_attributes }
#         product.reload
#         expect(response).to redirect_to(product_url(product))
#       end
#     end

#     context "with invalid parameters" do
#       it "renders a successful response (i.e. to display the 'edit' template)" do
#         product = Product.create! valid_attributes
#         patch product_url(product), params: { product: invalid_attributes }
#         expect(response).to be_successful
#       end
#     end
#   end

#   describe "DELETE /destroy" do
#     it "destroys the requested product" do
#       product = Product.create! valid_attributes
#       expect {
#         delete product_url(product)
#       }.to change(Product, :count).by(-1)
#     end

#     it "redirects to the products list" do
#       product = Product.create! valid_attributes
#       delete product_url(product)
#       expect(response).to redirect_to(products_url)
#     end
#   end
# end
