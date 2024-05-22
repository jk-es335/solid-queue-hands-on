class CreateJobCompletions < ActiveRecord::Migration[7.1]
  def change
    create_table :job_completions do |t|
      t.string :uuid
      t.string :adapter
      t.datetime :completed_at

      t.timestamps
    end
  end
end
