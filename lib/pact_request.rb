require 'policy'
require 'representable/xml'

class SelectTimeSpanEntity
  include Representable::XML

  attr_accessor :quickSearch1
  property :quickSearch1
end

class Target
  include Representable::XML

  attr_accessor :SelectTimeSpanEntity
  property :SelectTimeSpanEntity, :class => SelectTimeSpanEntity
end

class Params
  include Representable::XML
  
  attr_accessor :descriptionPattern
  property :descriptionPattern
end

class ReturnNode
  include Representable::XML

  attr_accessor :params
  property :params, :class => Params
end

class PactRequest
  include Representable::XML

  attr_accessor :target
  attr_accessor :return_node
  property :target, :class => Target
  property :return_node, :from => :return, :class => ReturnNode

  def initialize xml
    from_xml xml
  end

  def self.fromXml xml
    PactRequest.new xml
  end

  def execute
    policy = Policy.find_by_number target.SelectTimeSpanEntity.quickSearch1
    policy.get_description return_node.params.descriptionPattern
  end
end
