require 'environment'
require 'database'
require 'sinatra'
require 'haml'
require 'application'
require 'log'
require 'pact_request'

helpers do
  def display name, context = {}
    application = Application.new name
    haml name, :locals => context.merge(:application => application)
  end

  def redirect_back_with_error message
    redirect "#{request.referer}".split('?')[0] + "?message=#{CGI.escape(message)}&json=#{CGI.escape(params[:json])}"
  end
end

before do
  RoarExt::Domain::Hypermedia.base_url = request.base_url
  URI.base = request.base_url
  Log.info "#{settings.environment}: Calling #{request.request_method} on #{request.path_info}"
end

get '/' do
  display :home
end

post '/pactengine/pactREST/requests' do
  PactRequest.fromXml(params[:request]).execute()
end
