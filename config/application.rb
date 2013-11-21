require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)
ENV["REDISTOGO_URL"] = "redis://redistogo:15319dfc1e4014a747b5f5883c35d45d@grideye.redistogo.com:9190/"

module Messagehub
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    Urbanairship.application_key = 'UHVAmz_TQZq22AhHF8op-Q'
    Urbanairship.application_secret = 'LbKqJiyXSHCLrbi2aV__JA'
    Urbanairship.master_secret = '2KOb-cpBQVSLk189tjbeBQ'
    Urbanairship.logger = Rails.logger
    Urbanairship.request_timeout = 5
  end
end
