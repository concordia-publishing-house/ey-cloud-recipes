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
  :concurrency => 10,
  
  # Queues
  :queues => {
    # :queue_name => priority
    "unite:invite" => 1,
    "unite:user_invite" => 1,
    "unite:event_reminder" => 1
  },
  
  # Verbose
  :verbose => false
}
