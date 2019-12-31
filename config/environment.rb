ENV['SINATRA_ENV'] ||= 'development'
ENV['SINATRA_ACTIVESUPPORT_WARNING'] = 'false'

require 'dotenv'
Dotenv.load

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

require './app'
require_all 'models'
