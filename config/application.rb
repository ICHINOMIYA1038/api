require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.action_dispatch.default_headers = {
      'X-Frame-Options' => 'ALLOWALL'
    }

    config.autoload_paths += [
      "#{config.root}/app/helpers", # 例: app/helpersディレクトリを読み込む
      "#{config.root}/lib",         # 例: libディレクトリを読み込む
      # 追加のディレクトリを必要に応じて指定する
    ]
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
