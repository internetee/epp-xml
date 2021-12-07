require 'active_support/core_ext/string/filters'
require 'nokogiri'
require 'active_support'
require 'epp-xml'
require 'pry'

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end
