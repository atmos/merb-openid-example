require File.dirname(__FILE__) + "/rubundler"
r = Rubundler.new
r.setup_env
r.setup_requirements

# Go to http://wiki.merbivore.com/pages/init-rb
 
use_orm :datamapper
use_test :rspec
use_template_engine :erb
 
Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = 'datamapper'  # can also be 'memory', 'memcache', 'container', 'datamapper

  # cookie session store configuration
  # c[:session_secret_key]  = '31ce315bcf759bca292bd7a0892b861e5a2c2225'  # required for cookie session store
  # c[:session_id_key] = '_session_id' # cookie session id key, defaults to "_session_id"
end

Merb::BootLoader.before_app_loads do
  # This will get executed after dependencies have been loaded but before your app's classes have loaded.
end

Merb::BootLoader.after_app_loads do
  DataMapper.auto_migrate!
  # This will get executed after your app's classes have been loaded.
end
