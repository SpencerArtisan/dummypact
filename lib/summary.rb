require 'roar_ext'
require 'call'

class Summary
  include Representable::JSON
  
  collection :calls

  attr_accessor :calls

  def initialize calls
    @calls = calls
  end

  def self.instance

  end
end
