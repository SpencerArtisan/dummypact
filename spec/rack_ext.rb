RSpec::Matchers.define :redirect_to do |expected|
  match do |actual|
    actual.should be_redirect
    actual.location.should == expected
  end

  failure_message_for_should do |actual|
    actual.redirect? ?  "expected redirect to #{expected} it was to #{actual.location}" : 'expected a redirect, but it was not' 
  end
end

RSpec::Matchers.define :set_cookie_to do |expected|
  match do |actual|
    actual.headers['Set-Cookie'] == expected
  end

  failure_message_for_should do |actual|
    "expected cookie to be '#{expected}', but was '#{actual.headers['Set-Cookie']}'"
  end
end
