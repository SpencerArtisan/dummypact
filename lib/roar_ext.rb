require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module RoarExt
  module Domain
    module Hypermedia
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia

      class << self; attr_accessor :base_url; end

      def url link_symbol = :self
        link = find_url link_symbol
        raise ArgumentError.new("No such link '#{link_symbol}' for #{self.class}") if link.nil?
        link.href
      end

      def has_url? link
        find_url link
      end

      def find_url link
        before_serialize
        links[link.to_s]
      end

      def self.included(base)
        base.extend ClassMethods
        base.class_eval do
          include Representable::JSON
        end
      end

      module ClassMethods
        include Roar::Representer::JSON::ClassMethods
        include Roar::Representer::Feature::Hypermedia::ClassMethods

        def relative_link(options, &block)
          link options do
            prefix = RoarExt::Domain::Hypermedia.base_url
            relative_url = instance_exec &block
            (prefix || '') + relative_url unless relative_url.nil?
          end
        end
      end
    end
  end
end
