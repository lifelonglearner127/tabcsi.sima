# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersMailer do
  let(:sender_email) { Nenv.instance.mailer_sender }

  describe 'request_pin' do
    let(:email_subject) { t('users_mailer.request_pin.subject') }
    let(:recipient_email) { Faker::Internet.safe_email }
    let(:pin) { Faker::Number.number(8) }

    let(:mail) do
      described_class.with(
        recipient: recipient_email,
        pin: pin
      ).request_pin
    end

    it 'renders the subject' do
      expect(mail.subject).to eq(email_subject)
    end

    it 'renders the recipient email' do
      expect(mail.to).to eq([recipient_email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq([sender_email])
    end

    it 'assigns @pin' do
      expect(mail.body.encoded).to match(pin)
    end
  end
end
