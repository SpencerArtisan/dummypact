require 'sequel'
require 'policy_holder'

class Policy < Sequel::Model
  one_to_one :policyHolder, :class => PolicyHolder

  def get_description pattern
    puts "pattern is #{pattern}" 
    #pattern.gsub!(/:(.*){/, '{\1')
    pattern.gsub!(/\[(\w*)\.{(\w*)}/, '#{\1.\2}')
    pattern.gsub!(/[\[\]]/, '')
    puts "Pattern is #{pattern}"
    eval('"'+ pattern +'"')
  end
end
