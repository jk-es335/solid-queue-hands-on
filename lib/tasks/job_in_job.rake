namespace :job_in_job do
  desc 'Run job in job and monitor job completions'
  task :run, [:queue_size] => :environment do |t, args|
    STDOUT.sync = true

    io = Logger.new STDOUT

    if args[:queue_size].nil?
      io.info "Please provide the number of jobs to run. Example: rake job_in_job:run[10]"
      exit
    end

    queue_size = args[:queue_size].to_i

    uuid = SecureRandom.uuid

    io.info "Started #{queue_size} jobs. (uuid: #{uuid})"

    # Run your job here. For example:
    Thread.new(queue_size, uuid) do |_queue_size, _uuid|
      Rails.application.executor.wrap do
        ActiveRecord::Base.transaction do
          _queue_size.times do
            JobInJob.perform_later(_uuid)
          end
        end
      end
    end

    # Monitor job completions
    loop do
      completed_jobs = JobCompletion.where(uuid: uuid).count
      if completed_jobs >= queue_size
        io.info "All #{completed_jobs} jobs completed. (uuid: #{uuid})"
        break
      else
        io.info "#{completed_jobs} out of #{queue_size} jobs completed. (uuid: #{uuid})"
        sleep 5
      end
    end
  end
end