require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Jilv
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Beijing'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    I18n.config.enforce_available_locales = false
    config.i18n.load_path += Dir[Rails.root.join('app', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.available_locales = %w[en zh-CN zh-TW ja ko fr de es it]
    config.i18n.default_locale = :'zh-CN'
    config.i18n.fallbacks = [:en]

    config.action_mailer.smtp_settings = YAML.load_file(Rails.root.join('config', 'mailer.yml'))['smtp'].symbolize_keys
    config.sass.preferred_syntax = :sass
  end
end
