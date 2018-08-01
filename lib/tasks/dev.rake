# frozen_string_literal: true

require 'csv'

namespace :dev do
  if Rails.env.development? || Rails.env.test?
    require 'factory_bot'

    desc 'Sample data for local development environment'
    task prime: 'db:setup' do
      include FactoryBot::Syntax::Methods

      # create(:user, email: 'user@example.com', password: 'password')
    end
  end

  desc 'Sample vendor data.'
  task vendors: :environment do
    previous_line_length = 0

    CSV.foreach(
      Rails.root.join('lib', 'sample_vendors.csv'),
      headers: true,
      return_headers: false,
      skip_blanks: true
    ) do |row|
      row_hash = row.to_hash.transform_keys(&:to_sym)
      owner_id = row_hash.delete(:owner_id)
      name = row_hash.delete(:name)
      line = "Owner Id: #{owner_id}, Location Name: #{name}"

      print line

      company = Company.find_or_create_by!(owner_id: owner_id)

      location = Location.find_or_create_by!(
        company: company,
        name: name,
        address1: row_hash.delete(:address1),
        address2: row_hash.delete(:address2),
        address3: row_hash.delete(:address3),
        city: row_hash.delete(:city),
        county: row_hash.delete(:county),
        state: row_hash.delete(:state),
        country: 'United States',
        postal_code: row_hash.delete(:postal_code)
      )

      License.create!(
        company: company,
        location: location,
        **row_hash
      )

      license_text = ", License: #{row_hash[:license_type]}" \
        " #{row_hash[:license_number]}"
      line += license_text
      spaces = ''

      if line.length < previous_line_length
        spaces = ' ' * (previous_line_length - line.length)
      end

      print "#{license_text}#{spaces}\r"

      previous_line_length = line.length
    end
  end
end
