ENV['SINATRA_ENV'] ||= 'development'
ENV['SINATRA_ACTIVESUPPORT_WARNING'] = 'false'

require 'dotenv'
Dotenv.load

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require './app'
require_all 'models'
