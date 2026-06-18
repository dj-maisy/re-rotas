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
    config.load_defaults 7.2

    # Add recommended security headers and apply a basic lenient Content Security Policy
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

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    #
    config.eager_load_paths << config.root.join("lib")

    config.active_job.queue_adapter = :async

    config.middleware.use Prometheus::Middleware::Collector
    config.middleware.use Prometheus::Middleware::Exporter
    Prometheus::Client.config.data_store = Prometheus::Client::DataStores::DirectFileStore.new(dir: "tmp/metrics")
  end
end
