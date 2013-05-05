require 'test_environment'
require 'email'

describe Skeleton::Email do
  it 'should render from haml' do
    email = Skeleton::Email.new :body => '%p a body', :subject => 'a subject', :from => 'a sender'
    email.should_receive(:deliver_message).with :html => "<p>a body</p>\n", :subject => 'a subject', 
      :from_email => 'a sender', :from_name => 'a sender', :to => [{:email => 'a recipient'}]

    email.deliver 'a recipient'
  end

  it 'should render a context object within the haml' do
    model = OpenStruct.new :name => 'Stu'
    email = Skeleton::Email.new :body => '%p= "Hello #{model.name}"'
    email.model = model
    email.html_body.should == "<p>Hello Stu</p>\n"
  end
end
