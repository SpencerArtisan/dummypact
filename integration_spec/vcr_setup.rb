require 'vcr'

RSpec.configure do |config|
  config.around(:each) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").gsub(/[^\w\/]+/, "_")
    VCR.use_cassette(name, {}, &example)
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'integration_spec/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_request { |request| request.uri.include? '__identify__' }
  c.extend VCR::RSpec::Macros
end

