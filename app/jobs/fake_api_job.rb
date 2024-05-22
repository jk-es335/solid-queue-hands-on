class FakeApiJob < ApplicationJob
  # limits_concurrency to: 5, key: :fake_api_job, duration: 1.minutes
  self.queue_adapter = ENV['QUEUE_ADAPTER'].to_sym
  queue_as :default

  def perform(uuid)
    sleep(rand(1..10) * 0.1)
    JobCompletion.create(uuid: uuid, adapter: ENV['QUEUE_ADAPTER'] + "-#{ENV["HOSTNAME"]}", completed_at: Time.current)
  end
end
