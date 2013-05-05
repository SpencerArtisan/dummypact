require 'test_environment'
require 'in_memory_database'
require 'pact_request'

describe PactRequest do
  before do
    @xml = """
<pactrequest>
    <target>
        <SelectTimeSpanEntity>
            <entityType>policy</entityType>
            <rangeStart>0</rangeStart>
            <rangeEnd>50</rangeEnd>
            <quickSearch1>DLG/00000003</quickSearch1>
            <quickSearch4></quickSearch4>
        </SelectTimeSpanEntity>
    </target>
    <return>
        <name>asIdentifiedEntity</name>
        <params>
            <descriptionPattern>[Party Role:policyHolder.{assocUid}|[assocdescription.{quickSearch1}, {quickSearch4}|[clientIndDetails.{dob.dd/MM/yyyy}]|{quickSearch2}|[address.{addressLine1}]|{quickSearch3}|{status}]]</descriptionPattern>
        </params>
    </return>
</pactrequest>
    """
  end

  it 'should be creatable from xml' do
    request = PactRequest.fromXml @xml
    request.should_not be_nil
    request.target.SelectTimeSpanEntity.quickSearch1.should == 'DLG/00000003'
  end

  it 'should be able to perform a policy search' do
    policy = stub
    policy.stub(:get_description).with('[Party Role:policyHolder.{assocUid}|[assocdescription.{quickSearch1}, {quickSearch4}|[clientIndDetails.{dob.dd/MM/yyyy}]|{quickSearch2}|[address.{addressLine1}]|{quickSearch3}|{status}]]').and_return 'description'
    Policy.should_receive(:find_by_number).with('DLG/00000003').and_return policy
    request = PactRequest.fromXml @xml
    request.execute().should == 'description'
  end
end
