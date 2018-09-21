# frozen_string_literal: true

module TabcSi
  module Helpers
    def self.companies_with_max_coverage
      Company
        .includes(:licenses)
        .where(id: company_ids)
        .order(:owner_name)
        .select { |c| c.licenses.size > 1 }
        .map { |c| map_company(c) }
        .select { |o| select_object(o) }
    end

    def self.company_ids
      License
        .where(license_type: 'MB')
        .where('"licenses"."subordinate" NOT LIKE ?', '%LB%')
        .where('"licenses"."subordinate" LIKE ?', '%FB%')
        .or(
          License
            .where(license_type: 'N')
            .where('"licenses"."subordinate" NOT LIKE ?', '%LB%')
            .where('"licenses"."subordinate" LIKE ?', '%FB%')
            .where('"licenses"."subordinate" NOT LIKE ?', '%NL%')
        )
        .or(
          License
            .where(license_type: 'RM')
            .where('"licenses"."subordinate" NOT LIKE ?', '%LB%')
        )
        .group(:company_id)
        .pluck(:company_id)
    end

    def self.map_company(company)
      [
        company.owner_name,
        company.licenses.map do |l|
          "#{l.license_type}#{l.license_number} (#{l.subordinate})"
        end
      ]
    end

    def self.select_object(object)
      any_fb = object.last.any? { |l| any_fb?(l) }

      return false unless any_fb

      object.last.any? { |l| l.start_with?('BF', 'BQ', 'P', 'Q') }
    end

    def self.any_fb?(license)
      license.start_with?('RM') ||
        (license.start_with?('MB', /N[0-9]/) && license.include?('FB'))
    end
  end
end
