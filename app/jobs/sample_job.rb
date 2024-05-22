class SampleJob < ApplicationJob
  self.queue_adapter = ENV['QUEUE_ADAPTER'].to_sym
  queue_as :default

  def perform(uuid)
    JobCompletion.create(uuid: uuid, adapter: ENV['QUEUE_ADAPTER'] + "-#{ENV["HOSTNAME"]}", completed_at: Time.current)
  end
end
