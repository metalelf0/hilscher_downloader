require 'rspec'
require 'vcr'

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'hilscher_downloader'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :faraday # or :fakeweb
end
