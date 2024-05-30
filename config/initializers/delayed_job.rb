module SkipLockedDelayedJob
  def reserve_with_scope_using_optimized_mysql(ready_scope, worker, now)
    if __mysql_major_version >= 8
      # Removing the millisecond precision from now(time object)
      # MySQL 5.6.4 onwards millisecond precision exists, but the
      # datetime object created doesn't have precision, so discarded
      # while updating. But during the where clause, for mysql(>=5.6.4),
      # it queries with precision as well. So removing the precision
      now = now.change(usec: 0)

      # MySQL 8.0.1 onwards supports SKIP LOCKED
      sub_query = ready_scope.select(:id).limit(1).lock("FOR UPDATE SKIP LOCKED")

      count = joins("INNER JOIN (#{sub_query.to_sql}) AS `#{table_name}_sub` ON `#{table_name}_sub`.`id` = `#{table_name}`.`id`").
              update_all(locked_at: now, locked_by: worker.name)

      return nil if count == 0

      where(locked_at: now, locked_by: worker.name, failed_at: nil).first
    else
      super
    end
  end

  def __mysql_major_version
    @__mysql_major_version ||= ActiveRecord::Base.connection.select_value("SELECT VERSION()").first.to_i
  end
end

Rails.application.reloader.to_prepare do
  Delayed::Backend::ActiveRecord::Job.singleton_class.prepend(SkipLockedDelayedJob)
end
