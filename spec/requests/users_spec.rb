require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET :show' do
    it 'renders a successful response' do
      get user_path(user)

      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response.body).to include(user.name)
    end
  end
end
