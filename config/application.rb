require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Travel
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.time_zone = 'Tokyo'
    
    # 日本語の言語設定。この一行を追加。
    config.i18n.default_locale = :ja

config.i18n.available_locales = [:en, :ja]

  end
end
