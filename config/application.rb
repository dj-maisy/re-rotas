require_relative "boot"

require "logger"
require "rails/all"
require "prometheus/middleware/collector"
require "prometheus/middleware/exporter"
require "prometheus/client"
require "prometheus/client/data_stores/direct_file_store"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GdsRotas
  module CookieNames
    SESSION_COOKIE_NAME = "_gds_re_rotas_session".freeze
  end

  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Add recommended security headers
    config.action_dispatch.default_headers = {
      "X-Frame-Options" => "DENY",
      "X-Content-Type-Options" => "nosniff",
    }

    config.session_store :cookie_store,
      key: GdsRotas::CookieNames::SESSION_COOKIE_NAME,
      expire_after: 24.hours,
      secure: Rails.env.production? || Rails.env.staging?,
      http_only: true,
      same_site: :lax

    config.assets.paths << Rails.root.join("node_modules/flowbite/lib/cjs")
    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    config.eager_load_paths << config.root.join("lib")

    config.active_job.queue_adapter = :async

    config.middleware.use Prometheus::Middleware::Collector
    config.middleware.use Prometheus::Middleware::Exporter
    Prometheus::Client.config.data_store = Prometheus::Client::DataStores::DirectFileStore.new(dir: "tmp/metrics")

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
