require 'email_support'

module Skeleton
  class Email; end

  describe EmailSupport do
    let (:email) { stub }

    before do
      Email.stub :new => email

      class Subject
        include EmailSupport
        email_template :a_template, {:an_attribute => :an_attribute_value}
      end
    end

    it 'should store templates' do
      subject = Subject.new
      email.should_receive(:model=).with subject
      email.should_receive(:deliver).with 'A Recipient'
      subject.deliver_email :a_template, 'A Recipient'
    end
  end
end
