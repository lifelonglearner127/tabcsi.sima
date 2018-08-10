# frozen_string_literal: true

module TabcSi
  module Helpers
    def self.companies_with_max_coverage
      Company
        .includes(:licenses)
        .where(id: rm_company_ids)
        .order(:owner_name)
        .select { |c| c.licenses.size > 1 }
        .reject { |c| reject_company(c) }
        .map { |c| map_company(c) }
        .select { |o| select_object(o) }
    end

    def self.rm_company_ids
      License
        .where(license_type: 'RM')
        .group(:company_id)
        .pluck(:company_id)
    end

    def self.reject_company(company)
      company.licenses.any? do |l|
        l.license_type == 'RM' && l.subordinate.include?('LB')
      end
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
      any_rm = object.last.any? { |l| l.start_with?('RM') }

      return false unless any_rm

      object.last.any? { |l| l.start_with?('BF', 'BQ', 'P', 'Q') }
    end
  end
end
