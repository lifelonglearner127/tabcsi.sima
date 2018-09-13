# frozen_string_literal: true

require 'English'

module TabcSi
  class DataFeed
    include Singleton
    include Output

    COLUMN_HEADERS = %i[
      clp related_to name tabc_id owner_name street_number address address2
      address3 city state postal_code phone_number county email1 email2 status
      expires_on subordinate
    ].freeze

    REQUIRED_COLUMNS = %i[
      owner_name clp name address city postal_code status
    ].freeze

    attr_reader :seen_companies

    def self.load(path)
      instance.load(path)
    end

    def initialize
      @seen_companies = {}
      @previous_line_length = 0
      @current_line_length = 0
    end

    def load(path)
      ApplicationRecord.transaction do
        log('Loading existing data...')
        old_data = load_existing_data
        log_line(' done.')

        log('Loading csv...')
        new_data = load_csv(path)
        log_line(' done.')

        process_data(old_data, new_data)
        log_line('Done.')
      end
    end

    private

    def add_updated_attributes(attributes, attribute_names, object, data)
      attribute_names.each do |attr_name|
        value = data[attr_name]
        attributes[attr_name] = value if object.__send__(attr_name) != value
      end
    end

    def insert_company(owner_name)
      Company.find_or_create_by!(owner_name: owner_name)
    end

    def insert_license(company, clp, data)
      location = insert_location(company, clp, data)

      license_type = data[:license_type]
      license_number = data[:license_number]

      attrs = {
        company_id: company.id,
        location_id: location.id,
        clp: clp,
        license_type: license_type,
        license_number: license_number,
        status: data[:status],
        expires_on: data[:expires_on],
        subordinate: data[:subordinate],
        related_to: data[:related_to]
      }

      License.create!(attrs)
    end

    def insert_location(company, clp, data)
      attrs = {
        company_id: company.id,
        name: data[:name],
        address1: data[:address1],
        address2: data[:address2],
        address3: data[:address3],
        city: data[:city],
        county: data[:county],
        state: data[:state],
        country: 'United States',
        postal_code: data[:postal_code],
        phone_number: data[:phone_number],
        clp: clp
      }

      Location.create!(attrs)
    end

    def load_csv(path)
      data = []

      CSV.read(
        path,
        col_sep: '|',
        quote_char: "\0",
        headers: COLUMN_HEADERS,
        return_headers: false,
        skip_blanks: true
      ).each do |row|
        # silently skip rows which are empty or missing required data
        if row.fields.compact.empty? ||
           !row.to_hash.fetch_values(*REQUIRED_COLUMNS).all?
          next
        end

        hash = remap_columns(row)
        data << hash if hash.present?
      end

      data
    end

    def load_existing_data
      licenses =
        License
        .with_discarded
        .includes(%i[unscoped_company unscoped_location])

      Hash[
        licenses.map do |license|
          license_type = license.license_type
          license_number = license.license_number
          clp = license.clp || License.clp(license_type, license_number)

          [clp, license]
        end
      ]
    end

    def process_data(old_data, new_data)
      new_data.each do |row|
        clp = row[:clp]
        owner_name = row[:owner_name]
        license = old_data.delete(clp)

        log("Processing: #{clp}...")

        company = seen_companies[owner_name]
        company = license.company if company.blank? && license.present?
        company = insert_company(owner_name) if company.blank?

        company.undiscard if company.discarded?
        update_company(company, owner_name) if company.owner_name != owner_name

        seen_companies[owner_name] = company

        if license.blank?
          log(' inserting...')
          insert_license(company, clp, row)
        else
          log(' updating...')
          update_license(company, clp, license, row)
        end

        log(' processed.')
        reset_line
      end

      # anything left over in old_data needs to be marked as discarded
      old_data.each do |clp, license|
        log("Discarding: #{clp}...")

        company = license.company
        if company.present? && !seen_companies.key?(company.owner_name)
          company.discard
        end

        location = license.location
        if location.present? &&
           (company.discarded? || location.licenses.size <= 1)
          location.discard
        end

        license.discard

        log(' discarded.')
        reset_line
      end
    end

    def remap_columns(row)
      row_hash = row.to_hash

      # strip leading and trailing whitespace, and replace empty values with nil
      row_hash.transform_values! do |v|
        value = v.present? ? v.strip : v
        value.blank? ? nil : value
      end

      clp = row_hash.delete(:clp)
      license_type, license_number = *License.split_license_number(clp).values

      return nil if license_type.blank? || license_number.blank?

      street_number = row_hash.delete(:street_number)
      address1 = row_hash.delete(:address)
      address1 = "#{street_number} #{address1}" if street_number.present?

      row_hash[:clp] = License.clp(license_type, license_number)
      row_hash[:license_type] = license_type
      row_hash[:license_number] = license_number
      row_hash[:address1] = address1

      # disable expires_on until data feed is fixed
      # row_hash[:expires_on] = Date.strptime(row_hash[:expires_on], '%D')
      row_hash[:expires_on] = nil

      row_hash
    end

    def update_company(company, owner_name)
      company.update!(owner_name: owner_name)
    end

    def update_license(company, clp, license, data)
      license.undiscard if license.discarded?

      location = license.location
      if location.clp.present? && location.clp != clp
        # wrong location association
        location = insert_location(company, clp, data)
      end

      update_location(location, data)

      attrs = {}
      attrs[:location_id] = location.id if license.location_id != location.id

      add_updated_attributes(
        attrs, %i[clp status expires_on subordinate related_to], license, data
      )

      license.update!(attrs) unless attrs.empty?
    end

    def update_location(location, data)
      location.undiscard if location.discarded?

      attrs = {}

      add_updated_attributes(
        attrs,
        %i[
          name address1 address2 address3 city county state postal_code
          phone_number clp
        ],
        location,
        data
      )

      location.update!(attrs) unless attrs.empty?
    end
  end
end
