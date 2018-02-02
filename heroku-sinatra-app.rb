# You'll need to require these if you
# want to develop while running with ruby.
# The config/rackup.ru requires these as well
# for it's own reasons.
#
# $ ruby heroku-sinatra-app.rb
#
require 'sinatra'
require_relative 'gridium_data'

# Quick test
get '/' do
  data = GridiumData.new("https://snapmeter.com/api/v2/531e19848df5cb0b35014e85/meters/2166484536790/bill-summary?token=6d547442-417b-41a3-8838-b022f9c2974d")
  @json = data.get_json
  erb :index
end