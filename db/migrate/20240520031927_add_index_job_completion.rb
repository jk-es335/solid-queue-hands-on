class AddIndexJobCompletion < ActiveRecord::Migration[7.1]
  def change
    add_index :job_completions, [:uuid, :completed_at]
  end
end
