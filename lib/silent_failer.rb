require 'log'

class SilentFailer
  def initialize subject
    @subject = subject
  end

  def method_missing method, *args, &block
    begin
      @subject.send method, *args, &block
    rescue Exception => e
      Log.warn "Silently failed call to #{method} with args #{args} and block #{block}: #{e}"
      nil
    end
  end
end

