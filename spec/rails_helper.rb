# frozen_string_literal: true

require 'nenv'

if Nenv.instance.coverage?
  require 'simplecov'

  SimpleCov.start 'rails'
end

require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production.
if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end

require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc, in
# `spec/support/` and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in `spec/support` that end
# in `_spec.rb` will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with `_spec.rb`. You can configure this pattern with the --pattern option
# on the command line or in `~/.rspec`, `.rspec` or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

module Features
  # Extend this module in `spec/support/features/*.rb`.
  include Formulaic::Dsl
end

RSpec.configure do |config|
  config.include(Features, type: :feature)

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures.
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.infer_base_class_for_anonymous_controllers = false

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.use_transactional_fixtures = true
end

# Checks for pending migrations and applies them before tests are run. If you
# are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
