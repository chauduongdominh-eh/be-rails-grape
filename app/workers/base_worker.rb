# frozen_string_literal: true

class BaseWorker
  include Sidekiq::Job

  # Override this method to implement the worker
  def run(...); end

  def perform(...)
    return if cancelled?

    run(...)
  end

  def cancelled?
    Sidekiq.redis { |c| c.exists("cancelled-#{jid}") == 1 }
  end

  # Not sure if this is useful, we need to track Job ID to cancel the job,
  # but we are not doing that here.
  #
  # Anyway, this is an educational project, should be fine
  def self.cancel!(jid)
    Sidekiq.redis { |c| c.set("cancelled-#{jid}", 1, ex: 86_400) }
  end
end
