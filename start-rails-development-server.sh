echo 'starting Rails server ...' && rm -f tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0
echo 'Starting webpack dev server ...' && bin/webpack --watch --colors --progress
echo 'Starting Sidekiq server ...' && bundle exec sidekiq
