require 'json'
require 'uri'
require 'date'

class Hash
  def to_json_string
    String.new self.to_json
  end
end

class Fixnum
  def days 
    hours * 24 
  end  

  def hours
    minutes * 60 
  end  

  def minutes
    self * 60 
  end  

  alias_method :day, :days
end

class Numeric
  def to_money
    value_as_float = "%.2f" % self
    with_2_decimal_places = value_as_float.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    with_required_decimal_places = with_2_decimal_places.gsub /\.00$/, ''
    '$' + with_required_decimal_places
  end
end

class Date
  def self.latest first, second
    first < second ? second : first
  end
end

class Time
  def to_date
    Date.parse self.to_s
  end

  def to_date_string
    strftime "%-m/%-d/%Y"
  end
end

module URI
  class << self; attr_accessor :base; end

  def URI.to_absolute relative
    "#{base}#{relative}"
  end
end
