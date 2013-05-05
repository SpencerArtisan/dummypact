require 'silent_failer'

describe SilentFailer do
  let (:subject) { stub }
  let (:delegate) { SilentFailer.new subject }

  it 'should do a simple delegation' do
    subject.should_receive(:a_method).with(:an_argument).and_return :a_value
    result = delegate.a_method :an_argument
    result.should == :a_value
  end

  it 'should return nil if the method raises an exception' do
    subject.stub(:a_method).and_raise Exception
    result = delegate.a_method :an_argument
    result.should be_nil
  end
end
