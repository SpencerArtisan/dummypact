require 'sinatra/main'
require 'ruby_ext'

configure :production, :staging, :development do
  set :database, 'artisan'
  set :database_user, 'artisan'
  set :database_password, 'artisan'
  set :database_host, 'localhost'
  set :database_port, '5432'
end

configure :test, :production, :staging, :development do
  set :root, File.dirname(__FILE__) + "/../"
  set :port, ARGV[0]
  set :dump_errors, true
  set :show_exceptions, false
  set :raise_errors, false
  set :memcache_server, '0.0.0.0:11211'
  set :memcache_username, ''
  set :memcache_password, ''
  set :memcached_expiry, 3.days
  set :pact_url, 'http://localhost:8080/pactengine/pactREST/requests'
  #set :pact_url, 'http://10.178.0.217:8080/pactengine/pactREST/requests' # devlpact2
  set :napier_url, 'http://10.178.15.92:8080/loadbalancer/REST/calcs'
end

configure :test do
  #comment out below line to get more information on server_spec test failures
  set :raise_errors, true
end
