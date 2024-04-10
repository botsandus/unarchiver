# frozen_string_literal: true

require "unarchiver"

require "active_support/core_ext/class"
require "rspec/rails/file_fixture_support"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.add_setting :file_fixture_path, default: "spec/fixtures/files"
  config.include RSpec::Rails::FileFixtureSupport
end
