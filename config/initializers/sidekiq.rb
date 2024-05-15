# frozen_string_literal: true

require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { id: "Sidekiq-server-PID-#{::Process.pid}" }
  config.logger.formatter = Sidekiq::Logger::Formatters::JSON.new
end
