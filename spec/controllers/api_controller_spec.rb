# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApisController, type: :controller do
  describe 'GET #docs' do
    it 'returns http success' do
      get :docs
      expect(response).to have_http_status(:success)
    end
  end
end
