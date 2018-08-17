# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersMailer do
  describe 'request_pin' do
    let(:mail) { UsersMailer.request_pin }

    it 'renders the subject' do
      expect(mail.subject).to eq('Request pin')
    end

    it 'renders the recipient email' do
      expect(mail.to).to eq(['to@example.org'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end
