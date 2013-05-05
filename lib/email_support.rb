require 'log'
require 'email'

module Skeleton
  module EmailSupport
    def self.included(base)
      base.extend ClassMethods
    end

    def deliver_email template, to
      Log.info "Delivering email #{template} to #{to}"
      email = self.class.emails[template]
      raise ArgumentError, "No email template '#{template}'" if email.nil?
      email.model = self
      email.deliver to
    end

    module ClassMethods
      def emails
        @emails ||= {}
      end

      def email_template name, attributes
        emails[name] = Email.new attributes
      end
    end
  end
end

