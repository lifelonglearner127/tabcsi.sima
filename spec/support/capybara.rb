# frozen_string_literal: true

# seconds to wait before timeout error; default is 2
# Capybara.default_wait_time = 8

# Register slightly larger than default window size...
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    window_size: [1280, 720] # HD 720; covers the XL breakpoint
  )
end

Capybara.javascript_driver = :poltergeist

# Saves page to place specified at name inside of `test.rb` definition of:
#
#     config.integration_test_renders_dir = Rails.root.join('spec', 'renders')
#
# NOTE: you must pass "js:" for the scenario definition, otherwise you'll see
# that render doesn't exist!.
# def render_page(name)
#   png_name = name.strip.gsub(/\W+/, '-')
#   path = File.join(
#     Rails.application.config.integration_test_renders_dir,
#     "#{png_name}.png"
#   )
#   page.driver.render(path)
# end

# Shortcut for typing `save_and_open_page`.
# def page!
#   save_and_open_page
# end
