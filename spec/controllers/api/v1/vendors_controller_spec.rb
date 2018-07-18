# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::VendorsController, type: :controller do
  describe 'GET #names' do
    it 'returns http success' do
      get :names
      expect(response).to have_http_status(:success)
    end
  end
end
