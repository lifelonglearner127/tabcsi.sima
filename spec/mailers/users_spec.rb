# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersMailer, type: :mailer do
  describe 'request_pin' do
    let(:mail) { UsersMailer.request_pin }

    it 'renders the headers' do
      expect(mail.subject).to eq('Request pin')
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end
