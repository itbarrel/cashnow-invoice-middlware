require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["admin", "12345678"]
end

Sidekiq.default_worker_options = { retry: 0 }
