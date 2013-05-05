require 'roar_ext'

class Subject
  include RoarExt::Domain::Hypermedia

  relative_link :some_link do
    '/a_url'
  end
end

describe RoarExt do
  before do
    RoarExt::Domain::Hypermedia.base_url = 'base_url'
  end

  it 'should return a absolute link' do
    Subject.new.url(:some_link).should == 'base_url/a_url'
  end


  it 'should raise an exception if no such link' do
    expect { Subject.new.url(:blah) }.to raise_error ArgumentError
  end
end

