#
# Cookbook Name:: sidekiq
# Attrbutes:: default
#

default[:sidekiq] = {
  # Sidekiq will be installed on to application/solo instances,
  # unless a utility name is set, in which case, Sidekiq will
  # only be installed on to a utility instance that matches
  # the name
  :utility_name => 'sidekiq',

  # Number of workers (not threads)
  :workers => 1,

  # Concurrency
  :concurrency => 25,

  # Queues
  :queues => {
    # :queue_name => priority
    "members:email_contribution_statement" => 1,
    "members:email_invites" => 1,
    "members:church_directories" => 1,
    "members:contribution_statements" => 1,
    "members:mailing_labels" => 1,
    "members:attendance_sheets" => 1
  },

  # Verbose
  :verbose => false
}
