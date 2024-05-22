Rails.application.config.after_initialize do
  SolidQueue::ReadyExecution.singleton_class.prepend(Module.new do
    def lock_candidates(job_ids, process_id)
      return [] if job_ids.none?

      SolidQueue::ClaimedExecution.claiming(job_ids, process_id) do |claimed|
        where(id: where(job_id: claimed.pluck(:job_id)).pluck(:id)).delete_all
      end
    end
  end)
end
