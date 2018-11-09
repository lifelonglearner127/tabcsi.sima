# frozen_string_literal: true

module TabcSi
  class SettingsLoader
    def self.run
      Setting::DEFAULTS.each do |name, value|
        next if Setting.find_by(name: name).present?

        Setting.create!(name: name, value: value)

        puts "* Setting added: #{name} = #{value}"
      end
    end
  end
end
