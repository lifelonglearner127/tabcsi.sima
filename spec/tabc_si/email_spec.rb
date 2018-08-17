# frozen_string_literal: true

require 'rails_helper'

VALID_EMAILS ||= %w[
  simple@example.com
  very.common@example.com
  disposable.style.email.with+symbol@example.com
  other.email-with-hyphen@example.com
  fully-qualified-domain@example.com
  user.name+tag+sorting@example.com
  x@example.com
  "very.(),:;<>[]\\".VERY.\\"very@\\\\\ \\"very\\".unusual"@strange.example.com
  example-indeed@strange-example.com
  admin@mailserver1
  #!$%&'*+-/=?^_`{}|~@example.org
  "()<>[]:,;@\\\\\\"!#$%&'-/=?^_`{}|\ ~.a"@example.org
  example@s.example
  user@[2001:DB8::1]
  "\ "@example.org
].freeze

INVALID_EMAILS ||= %w[
  Abc.example.com
  A@b@c@example.com
  a"b(c)d,e:f;g<h>i[j\\k]l@example.com
  just"not"right@example.com
  this\ is"not\\allowed@example.com
  this\\\ still\\"not\\\\allowed@example.com
  john..doe@example.com
  john.doe@example..com
].freeze

RSpec.describe TabcSi::Email do
  describe '::valid?' do
    VALID_EMAILS.each do |email|
      it "returns true for valid email: #{email.inspect}" do
        expect(described_class.valid?(email)).to be true
      end
    end

    it 'returns false for empty email' do
      expect(described_class.valid?('')).to be false
    end

    INVALID_EMAILS.each do |email|
      it "returns false for invalid email: #{email.inspect}" do
        expect(described_class.valid?(email)).to be false
      end
    end
  end
end
