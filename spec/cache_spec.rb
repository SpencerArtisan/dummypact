require 'sinatra'
set :environment, :test
require 'cache'

describe Cache do
  let (:dalli) { stub 'dalli' }
  let (:subject) { stub 'subject' }
  let (:cache) { Cache.new subject }

  before do
    Dalli::Client.stub :new => dalli
  end

  it 'should delegate to the wrapped object if there is no data in the cache' do
    dalli.should_receive(:get).with(:a_method).and_return nil
    dalli.should_receive(:set).with :a_method, :a_value
    subject.should_receive(:a_method).with(:an_argument).and_return :a_value
    result = cache.a_method :an_argument
    result.should == :a_value
  end

  it 'should not delegate to the wrapped object if there is data in the cache' do
    dalli.should_receive(:get).with(:a_method).and_return :a_value
    result = cache.a_method :an_argument
    result.should == :a_value
  end

  it 'should handle the caching server being unavailable' do
    dalli.should_receive(:get).and_raise Exception
    subject.should_receive(:a_method).with(:an_argument).and_return :a_value
    result = cache.a_method :an_argument
    result.should == :a_value
  end
end
