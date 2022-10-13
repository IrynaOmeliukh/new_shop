require 'rails_helper'

RSpec.describe '/categories', type: :request do
  # describe "request list of all users" do
  #   category = Category.create(name: 'Test user')

  #   expect(response).to redirect_to(categories_path)

  #   expect(response.body).to include('Test user')
  # end

  # describe 'GET /index' do
  #   it 'renders a successful response' do
  #     post = Post.new(valid_attributes)
  #     post.user = current_user
  #     post.save
  #     get posts_url
  #     expect(response).to be_successful
  #   end
  # end


  # category = Category.first_or_create!(name: 'Name')
  let(:valid_attributes) do {
    'id' => '1',
    'name' => 'Name'
    }
  end

  let(:invalid_attributes) do {
    'id' => 'c',
    'name' => '123'
    }
  end

  describe "GET /index" do
    it "renders a successful response" do
      Category.create! valid_attributes
      get categories_path
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      category = Category.new(valid_attributes)
      category.save
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
      category = Category.new(valid_attributes)
      category.save
      get edit_category_path(category)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Category' do
        expect do
          category = Category.new(valid_attributes)
          category.save
          post categories_url, params: { category: valid_attributes }
        end.to change(Category, :count).by(1)
      end

      it 'redirects to the created Category' do
        post categories_path, params: { category: valid_attributes }
        expect(response).to be_successful
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Category' do
        expect do
          post categories_path, params: { category: invalid_attributes }
        end.to change(Category, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post categories_path, params: { category: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested post' do
      post = Post.new(valid_attributes)
      post.user = current_user
      post.save
      expect do
        delete post_url(post)
      end.to change(Post, :count).by(-1)
    end

    it 'redirects to the posts list' do
      post = Post.new(valid_attributes)
      post.user = current_user
      post.save
      delete post_url(post)
      expect(response).to redirect_to(posts_url)
    end
  end
end
