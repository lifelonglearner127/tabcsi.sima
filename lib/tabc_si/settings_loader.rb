# frozen_string_literal: true

module TabcSi
  class SettingsLoader
    def self.run
      {
        business_point_radius: 100, # feet
        server_status: :active,
        forms_build_date: Time.new(2018).strftime('%F'),
        fiscal_year: 2018,
        pin_length: 8,
        pin_expiration: 30.minutes
      }.each do |name, value|
        next if Setting.find_by(name: name).present?

        Setting.create!(name: name, value: value)

        puts "* Setting added: #{name} = #{value}"
      end
    end
  end
end
