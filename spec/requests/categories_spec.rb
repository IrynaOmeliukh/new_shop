require 'rails_helper'

RSpec.describe 'CategoriesController', type: :request do
  let!(:category) { create(:category) }
  let(:valid_attributes) { { category: { name: 'Books' } } }
  let(:invalid_attributes) { { category: { name: '' } } }
  let(:new_attributes) { { category: { name: 'Phones' } } }

  describe 'GET :index' do
    it 'is successful' do
      get categories_path

      expect(response).to be_successful
    end
  end

  describe 'GET :new' do
    it 'is successful' do
      get new_category_path
      expect(response).to be_successful
    end
  end

  describe 'GET :edit' do
    it 'is successful' do
      get edit_category_path(category)
      expect(response).to be_successful
    end
  end

  describe 'POST :create' do
    context 'with valid parameters' do
      it 'is successfull' do
        expect do
          post categories_url, params: valid_attributes
        end.to change(Category, :count).by(1)

        expect(response).to redirect_to(categories_path)
        expect(flash[:notice]).to eq('Category was successfully created.')
      end
    end

    context 'with invalid parameters' do
      it 'is not successful' do
        expect do
          post categories_path, params: invalid_attributes
        end.to change(Category, :count).by(0)

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH :update' do
    context 'with valid parameters' do
      it 'is successful' do
        patch category_url(category), params: new_attributes
        category.reload
        expect(category.name).to eq('Phones')
        expect(response).to redirect_to(categories_path)
        expect(flash[:notice]).to eq('Category was successfully updated.')
      end
    end

    context 'with invalid parameters' do
      it 'is not successful' do
        expect do
          patch category_url(category), params: invalid_attributes
        end.not_to change(category, :name)
        expect(response).to be_unprocessable
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE :destroy' do
    it 'destroys the requested category' do
      expect do
        delete category_url(category)
      end.to change(Category, :count).by(-1)

      expect(response).to redirect_to(categories_url)
      expect(flash[:notice]).to eq('Category was successfully destroyed.')
    end
  end
end
