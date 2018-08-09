# frozen_string_literal: true

module TabcSi
  class SettingsLoader
    def self.run
      {
        business_point_radius: 100, # feet
        server_status: :active,
        forms_build_date: 0
      }.each do |name, value|
        next if Setting.find_by(name: name).present?

        Setting.create!(name: name, value: value)

        puts "* Setting added: #{name} = #{value}"
      end
    end
  end
end