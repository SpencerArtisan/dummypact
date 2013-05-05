require 'json'
require 'net/http'
require 'net/https'
require 'log'
require 'environment'
require 'haml'

module Skeleton
  class Email
    attr_accessor :model

    def initialize attributes
      @plain_body = attributes[:plain_body]
      @haml_body = attributes[:body]
      @subject = attributes[:subject]
      @from = attributes[:from]
    end 

    def deliver to
      message = {:html => html_body,
                 :subject => @subject, 
                 :from_email => @from, 
                 :from_name => @from,
                 :to => [{:email => to}]}
      Log.info "Delivering email #{message}"
      deliver_message message
    end

    def html_body
      return @plain_body if @plain_body
      Log.info "Building html message with model '#{@model}'"
      Haml::Engine.new(@haml_body).render Object.new, :model => @model
    end

    def deliver_message message
      http = Net::HTTP.new settings.mailchimp_domain, settings.mailchimp_port
      http.use_ssl = true
      http.post settings.mailchimp_endpoint, {:key => settings.mailchimp_key, :message => message}.to_json
    end
  end
end

