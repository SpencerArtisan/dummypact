require 'ruby_ext'
require 'timecop'

describe Numeric do
  it 'should convert an integer to a currency string' do
    1234.to_money.should == '$1,234'
  end

  it 'should convert a float without decimal places to a currency string' do
    1234.to_f.to_money.should == '$1,234'
  end
  
  it 'should convert a float with 1 decimal place to a currency string' do
    1234.5.to_money.should == '$1,234.50'
  end

  it 'should convert a float with 3 decimal place to a currency string' do
    1234.567.to_money.should == '$1,234.57'
  end

  it 'should convert a float to a currency string' do
    1234.56.to_money.should == '$1,234.56'
  end
end

describe URI do
  it 'should convert a relative to an absolute uri' do
    URI.base = 'http://base.com'
    URI.to_absolute('/some/path').should == 'http://base.com/some/path'
  end
end

describe Time do
  it 'should format to a readable string' do
    time = Time.utc 2012, 11, 2, 13, 29, 22
    time.to_date_string.should == '11/2/2012'
  end
end

describe Date do
  it 'should determine the latter of two dates' do
    Timecop.freeze
    Date.latest(Date.today, Date.today - 1.day).should == Date.today
    Date.latest(Date.today - 1.day, Date.today).should == Date.today
  end
end
