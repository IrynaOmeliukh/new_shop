require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  let(:user) { create(:user) }

  describe 'GET :show' do
    it 'is successful' do
      get user_path(user)

      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response.body).to include(user.first_name)
    end
  end
end
