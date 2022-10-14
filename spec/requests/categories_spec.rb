require 'rails_helper'

RSpec.describe '/categories', type: :request do

  let!(:category) { create(:category) }

  let(:valid_attributes) do {
    category: { name: 'Books' }
    }
  end

  let(:invalid_attributes) do {
    category: { name: '' }
    }
  end

  let(:new_attributes) do {
    category: { name: 'Phones' }
    }
  end

  describe "GET /index" do
    it "renders a successful response" do
      get categories_path
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get categories_path(category)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_category_path
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      get edit_category_path(category)
      expect(response).to be_successful
    end
  end

  describe 'POST :create' do
    context 'with invalid parameters' do
      it 'creates a new Category' do
        expect do
          post categories_url, params: valid_attributes
        end.to change(Category, :count).by(1)
      end

      it 'redirects to the created Category' do
        post categories_path, params: valid_attributes
        # expect(response).to be_successful
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Category' do
        expect do
          post categories_path, params: invalid_attributes
        end.to change(Category, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post categories_path, params: invalid_attributes
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested post' do
        category.reload
        expect do
          patch category_url(category), params: new_attributes
        end.to change(Category, :count).by(1)
        # skip('Add assertions for updated state')

      end

      it 'redirects to the post' do
        patch category_url(category), params: new_attributes
        category.reload
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        # whyyyy ???????????????????????????????????????? whyyyy ?????????
        patch category_url(category), params: invalid_attributes
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE :destroy' do
    it 'destroys the requested category' do
      expect do
        delete category_url(category)
      end.to change(Category, :count).by(-1)
    end

    it 'redirects to the posts list' do
      delete category_url(category)
      expect(response).to redirect_to(categories_url)
    end
  end
end
