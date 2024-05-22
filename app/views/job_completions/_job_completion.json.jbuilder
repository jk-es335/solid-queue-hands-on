json.extract! job_completion, :id, :adapter, :completed_at, :created_at, :updated_at
json.url job_completion_url(job_completion, format: :json)
