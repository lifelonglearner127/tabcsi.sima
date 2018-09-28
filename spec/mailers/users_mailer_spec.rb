# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersMailer do
  let(:sender_email) { Nenv.instance.mailer_sender }

  describe 'request_pin' do
    let(:email_subject) { t('users_mailer.request_pin.subject') }
    let(:recipient_email) { Faker::Internet.safe_email }
    let(:full_name) { Faker::Name.full_name }
    let(:pin) { Faker::Number.number(Setting.pin_length) }

    let(:mail) do
      described_class.with(
        recipient: recipient_email,
        full_name: full_name,
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

    it 'assigns @full_name' do
      expect(mail.body.encoded).to match(full_name)
    end

    it 'assigns @pin' do
      expect(mail.body.encoded).to match(pin)
    end
  end

  describe 'welcome' do
    let(:email_subject) { t('users_mailer.welcome.subject') }
    let(:recipient_email) { Faker::Internet.safe_email }
    let(:full_name) { Faker::Name.full_name }

    let(:mail) do
      described_class.with(
        recipient: recipient_email,
        full_name: full_name
      ).welcome
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

    it 'assigns @recipient' do
      expect(mail.body.encoded).to match(recipient_email)
    end

    it 'assigns @full_name' do
      expect(mail.body.encoded).to match(full_name)
    end

    # TODO: test conditional @company_name
  end
end
