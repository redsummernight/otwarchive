redis_configs = YAML.load_file(Rails.root.join("config/redis.yml"))
redis_configs.each_pair do |name, redis_config|
  redis_host, redis_port = redis_config[Rails.env].split(":")
  redis_connection = Redis.new(host: redis_host, port: redis_port)

  if ENV["DEV_USER"]
    namespaced_redis = Redis::Namespace.new(ENV["DEV_USER"], redis: redis_connection)
    redis_connection = namespaced_redis
  end

  Object.const_set(name.upcase, redis_connection)
end
