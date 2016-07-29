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
    "members:email_contribution_statement" => 3,
    "members:email_invites" => 3,
    "members:church_directories" => 5,
    "members:contribution_statements" => 5,
    "members:mailing_labels" => 5,
    "members:attendance_sheets" => 5,
    "members:application_mailer" => 3,
    "members:geocoder" => 1
  },

  # Verbose
  :verbose => false
}
