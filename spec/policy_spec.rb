require 'test_environment'
require 'in_memory_database'
require 'policy'

describe Policy do
  it 'should provide a description containing properties on the policy' do
    policy = Policy.new :status => 'a status'
    pattern = "[{status}]"
    policy.get_description(pattern).should == 'a status'
  end

  it 'should provide a description containing properties on objects associated with the policy' do
    policy_holder = PolicyHolder.create :assocUid => 'a uid'
    policy = Policy.create
    policy.policyHolder = policy_holder
    pattern = "[Party Role:policyHolder.{assocUid}]"
    puts "**********"
    policy.get_description(pattern).should == 'a uid'
  end

  it 'should provide a complex description' do
    policy = Policy.new 
    pattern = "[Party Role:policyHolder.{assocUid}|[assocdescription.{quickSearch1}, {quickSearch4}|[clientIndDetails.{dob.dd/MM/yyyy}]|{quickSearch2}|[address.{addressLine1}]|{quickSearch3}|{status}]]"
    policy.get_description(pattern).should == 'ea0ae3f5-0101-007f-001c-5dd14f0063f4|Runner, Temple|01/03/1984|SY14 7NF|1 Well Cottages|temple@runner.com|Merged'
  end
end

[Party Role:policyHolder.{assocUid}
  [assocdescription.{quickSearch1}, {quickSearch4}
       [clientIndDetails.{dob.dd/MM/yyyy}]
    {quickSearch2}
       [address.{addressLine1}]
    {quickSearch3}
    {status}
  ]
]
ea0ae3f5-0101-007f-001c-5dd14f0063f4
  Runner, Temple
      01/03/1984
    SY14 7NF
      1 Well Cottages
    temple@runner.com
    Merged
