$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require "paymill"
require "rspec"
require "rspec/autorun"
require "webmock/rspec"
require "pry"

require "fake_logger"
Paymill.logger = FakeLogger.new

RSpec.configure do |config|
end
