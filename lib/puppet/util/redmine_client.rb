begin
  require 'active_resource'
rescue LoadError
  Puppet.err "The Puppet Ticket Face requires the 'activeresource' gem to be installed."
end

require 'puppet/util/redmine_client/base'
require 'puppet/util/redmine_client/project'
require 'puppet/util/redmine_client/issue'
require 'puppet/util/redmine_client/news'
