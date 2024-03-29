require 'test_environment'
require 'unreliable_object_delegate'

describe UnreliableObjectDelegate do
  before :each do
    @target = mock
    @delegate = UnreliableObjectDelegate.new @target, 0.001, 3
  end

  it 'should delegate method calls' do
    @target.should_receive(:some_method).with("arg1", "arg2").and_return("wibble")
    @delegate.some_method("arg1", "arg2").should == "wibble"
  end

  it 'should try calling again if the first call times out' do
    @target.should_receive(:some_method) { sleep 1; "first call slow response" }
    @target.should_receive(:some_method).and_return { "second call response" }
    @delegate.some_method.should == "second call response"
  end

  it 'should try calling for a given number of times' do
    @target.should_receive(:some_method).exactly(2).times { sleep 1; "slow response" }
    @target.should_receive(:some_method).and_return { "fifth call response" }
    @delegate.some_method.should == "fifth call response"
  end

  it 'should throw an exception if all attempts time out' do
    @target.should_receive(:some_method).exactly(3).times { sleep 1; "slow response" }
    lambda {@delegate.some_method}.should raise_error
  end

  it 'should return a default value if all attempts time out' do
    @delegate.handle_failure_with_default_return 'default'
    @target.should_receive(:some_method).exactly(3).times { sleep 1; "slow response" }
    @delegate.some_method.should == 'default'
  end
end

