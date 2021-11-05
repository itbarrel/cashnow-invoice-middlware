require 'sidekiq'
require 'sidekiq/web'

sidekiq_config = { url: ENV['REDIS_URL'] }

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["admin", "12345678"]
end

Sidekiq.default_worker_options = { retry: 0 }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end