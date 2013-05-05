require 'rack/test'
require_relative 'rack_ext'
require 'server'

describe 'server' do
  include Rack::Test::Methods

  it 'should handle GET on / by returning a home page' do
    get '/'
    last_response.body.should include 'Artisan'
  end

  it 'should handle pact posts by converting the xml request into a command and running it' do
    params = {'request' => 'request xml'}
    request = stub
    PactRequest.should_receive(:fromXml).with('request xml').and_return request
    request.should_receive(:execute).and_return 'some result'
    post '/pactengine/pactREST/requests', params
    last_response.body.should == 'some result'
  end

  def app
    Sinatra::Application
  end
end
