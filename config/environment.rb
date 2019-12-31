ENV['SINATRA_ENV'] ||= 'development'
ENV['SINATRA_ACTIVESUPPORT_WARNING'] = 'false'

if ENV['SINATRA_ENV'] == 'development'
	require 'dotenv'
	Dotenv.load
end

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

require './app'
require_all 'models'
