class JobInJob < ApplicationJob
  self.queue_adapter = ENV['QUEUE_ADAPTER'].to_sym
  queue_as :default

  def perform(uuid)
    SampleJob.perform_later(uuid)
  end
end
