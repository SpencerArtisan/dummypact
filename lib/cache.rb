require 'environment'
require 'dalli'
require 'log'
require 'silent_failer'

class Cache
  def initialize subject
    server = settings.memcache_server
    user = settings.memcache_username
    password = settings.memcache_password

    Log.info "Connecting to dalli server #{server}, username #{user}, password #{password}"
    cache = Dalli::Client.new server, :username => user, :password => password, :expires_in => settings.memcached_expiry
    @dalli_cache = SilentFailer.new cache
    @subject = subject
  end

  def method_missing method, *args, &block
    result = @dalli_cache.get method
    if result.nil?
      result = @subject.send method, *args, &block
      @dalli_cache.set method, result
    end
    result
  end
end

