require "resque"

redis_configs = YAML.load_file(Rails.root.join("config/redis.yml"))
Resque.redis = redis_configs["redis_resque"][Rails.env]

# For testing, run all jobs in the same process.
Resque.inline = Rails.env.test?

Resque.after_fork do
  Resque.redis.client.reconnect
end
