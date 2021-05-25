require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_mailer/railtie'
require 'action_controller/railtie'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
require 'faker'
# require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PetFinder
  class Application < Rails::Application
    config.load_defaults 6.1

    config.generators.system_tests = nil

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource 'search', :headers => :any, :methods => :post
      end
    end
  end
end
