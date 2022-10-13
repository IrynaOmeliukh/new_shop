require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'create' do
    it 'successfully creates a new category' do
      category = Category.create(name: 'TestName')

      expect(Category.last.name).to eq("TestName")
    end
  end

  describe 'update' do
    it 'successfully updates the category' do
      category = Category.create(name: 'TestName')
      category = Category.update(name: 'Updated')

      expect(Category.last.name).to eq("Updated")
    end
  end

  describe 'destroy' do
    let!(:category) { Category.create(name: 'TestName') }

    it 'successfully destroys the category' do
      expect do
        delete :destroy, params: { id: category.id }
      end.to change(Category, :count).by(-1)

      expect(response).to redirect_to(categories_path)
      expect(flash[:notice]).to eq('Category was successfully destroyed.')
    end
  end
end
