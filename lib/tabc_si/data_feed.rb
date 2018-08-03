# frozen_string_literal: true

require 'English'

module TabcSi
  class DataFeed
    include Singleton
    include Output

    COLUMN_REMAP = {
      relClp: :related_to,
      tradename: :name,
      owner: :owner_name,
      ll_streetaddressnbr: :street_number,
      ll_addressline1: :address,
      ll_addressline2: :address2,
      ll_addressline3: :address3,
      ll_cityname: :city,
      ll_statecode: :state,
      ll_zip: :postal_code,
      ll_phoneNbr: :phone_number,
      licStatusDesc: :status,
      expiryDate: :expires_on,
      allSub: :subordinate
    }.freeze

    REQUIRED_COLUMNS = %i[
      owner_name name address city postal_code clp status
    ].freeze

    attr_reader :companies
    attr_reader :locations

    def initialize
      @companies = {}
      @locations = {}
      @previous_line_length = 0
      @current_line_length = 0
    end

    def self.load(path)
      instance.load(path)
    end

    def load(path)
      load_csv(path) do |entry|
        unless entry.fetch_values(*REQUIRED_COLUMNS).all?
          log "Skipping line: #{$INPUT_LINE_NUMBER}"
          reset_line(true)
          next
        end

        company_info, location_info, license_info = split_up_entry(entry)

        log(
          "Owner Name: #{company_info[:owner_name]}, Location Name:" \
          " #{location_info[:name]}, License: #{license_info[:license_type]}" \
          " #{license_info[:license_number]}"
        )

        company = find_or_create_company(company_info)
        location = find_or_create_location(location_info, company)

        create_license(license_info, company, location)

        reset_line
      end

      puts ''
    end

    private

    def load_csv(path)
      CSV.foreach(
        path,
        headers: true,
        return_headers: false,
        skip_blanks: true
      ) do |row|
        next if row.fields.compact.empty? # silently skip no-data rows
        entry = remap_columns(row)
        yield entry
      end
    end

    def remap_columns(row)
      row_hash =
        row.to_hash.transform_keys do |k|
          remap_column(k.to_sym)
        end

      # strip leading and trailing whitespace, and replace empty values with nil
      row_hash.transform_values do |v|
        value = v.present? ? v.strip : v
        value.blank? ? nil : value
      end
    end

    def remap_column(key)
      COLUMN_REMAP[key] || key
    end

    def split_up_entry(entry)
      owner_name = entry[:owner_name]
      company_info = { owner_name: owner_name }

      street_number = entry[:street_number]
      address1 = entry[:address]
      address1 = "#{street_number} #{address1}" if street_number.present?
      address2 = entry[:address2]
      address3 = entry[:address3]
      city = entry[:city]
      state = entry[:state]
      postal_code = entry[:postal_code]

      key = [
        owner_name, address1, address2, address3, city, state, postal_code
      ].join(',')

      location_info = {
        key: key,
        name: entry[:name],
        address1: address1,
        address2: address2,
        address3: address3,
        city: city,
        state: state,
        postal_code: postal_code,
        phone_number: entry[:phone_number]
      }

      clp = entry[:clp]
      license_type, license_number = *License.split_license_number(clp).values
      license_info = {
        license_type: license_type,
        license_number: license_number,
        subordinate: entry[:subordinate],
        related_to: entry[:related_to],
        status: entry[:status],
        expires_on: Date.strptime(entry[:expires_on], '%D')
      }

      [company_info, location_info, license_info]
    end

    def find_or_create_company(company_info)
      owner_name = company_info[:owner_name]

      return companies[owner_name] if companies.key?(owner_name)

      company = Company.find_or_create_by!(owner_name: owner_name)
      companies[owner_name] = company

      company
    end

    def find_or_create_location(location_info, company)
      key = location_info[:key]
      return locations[key] if locations.key?(key)

      location_data = {
        company: company,
        address1: location_info[:address1],
        address2: location_info[:address2],
        address3: location_info[:address3],
        city: location_info[:city],
        state: location_info[:state],
        country: 'United States',
        postal_code: location_info[:postal_code]
      }

      location = Location.find_by(**location_data)
      if location.blank?
        location = Location.create!(
          name: location_info[:name],
          phone_number: location_info[:phone_number],
          **location_data
        )
      end

      locations[key] = location

      location
    end

    def create_license(license_info, company, location)
      license_type = license_info[:license_type]
      license_number = license_info[:license_number]
      license = License.find_by(
        license_type: license_type, license_number: license_number
      )

      return if license.present?

      License.create!(
        company: company,
        location: location,
        **license_info
      )
    end
  end
end
