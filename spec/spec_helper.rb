require 'paymill'
require 'vcr'
require 'pry'

# initialize the library by getting paymill's api key from the envirounent variables
Paymill.api_key = ENV['PAYMILL_API_TEST_KEY']

# VCR basic configuration
VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.default_cassette_options = { record: :new_episodes, re_record_interval: 1.week.to_i }
  config.configure_rspec_metadata!
  config.filter_sensitive_data( '<PAYMILL_API_TEST_KEY>' ) { ENV['PAYMILL_API_TEST_KEY'] }
end

# RSpec configuration
RSpec.configure do |config|
  # configure rspec to create VCR cassette names, based on rspec examples
  config.around( :each, :vcr ) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
    options = example.metadata.slice( :record, :match_requests_on ).except( :example_group )
    VCR.use_cassette( name, options ) { example.call }
  end
end
