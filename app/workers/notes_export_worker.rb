# frozen_string_literal: true

class NotesExportWorker < BaseWorker
  sidekiq_options queue: 'low'

  def run(args)
    sleep 5
    puts "Done for #{args['user_id']}"
  end
end
