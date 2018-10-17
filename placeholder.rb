# frozen_string_literal: true

require "connection_pool"
require "mock_redis"
require "sidekiq"

MockRedis::InfoMethod::DEFAULT_INFO["redis_version"] = "4.0.10"
MockRedis::InfoMethod::ALL_INFO["redis_version"]     = "4.0.10"

redis = ConnectionPool.new(:size => 3) { MockRedis.new }

Sidekiq.configure_server { |config| config.redis = redis }
Sidekiq.configure_client { |config| config.redis = redis }
