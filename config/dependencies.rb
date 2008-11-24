add_source "http://gems.rubyforge.org/"

add_gem 'rspec', '=1.1.11'
add_gem 'rake'
add_gem 'rcov'
add_gem 'mongrel'
add_gem 'hoe'
add_gem 'data_objects'
add_gem 'do_sqlite3'
add_gem 'ruby-openid', '=2.1.2'
add_gem 'rr', '=0.6.0'

add_dependency 'dm-core', '=0.9.7', :require => 'dm-core'
add_dependency 'dm-validations', '=0.9.7', :require => 'dm-validations'

add_dependency 'extlib', '=0.9.8', :require => 'extlib'
add_dependency 'merb-core', '=1.0.1', :require => 'merb-core'
add_dependency 'merb-gen', '=1.0.1'
add_dependency 'merb-auth-core', '=1.0.1', :require => 'merb-auth-core'
add_dependency 'merb-auth-more', '=1.0.1', :require => 'merb-auth-more'
add_dependency 'merb-auth-slice-password', '=1.0.1', :require => 'merb-auth-slice-password'
add_dependency 'merb-slices', '=1.0.1', :require => 'merb-slices'
add_dependency 'merb-param-protection', '=1.0.1', :require => 'merb-param-protection'
add_dependency 'merb_datamapper', '=1.0.1'

add_dependency 'nokogiri', '>=1.0.6'
add_dependency 'webrat', '=0.3.2'
