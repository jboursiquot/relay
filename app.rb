# encoding: utf-8
require 'sinatra'
require 'rack/contrib/jsonp'
require 'json'
require 'yaml'
require 'pony'

class App < Sinatra::Application

  use Rack::JSONP

  configure do
    env = ENV['RACK_ENV'] || "development"

    set :valid_token, ENV['RELAY_TOKEN']

    smtp_host = ENV['SMTP_HOST'] || "localhost"
    smtp_port = ENV['SMTP_PORT'] || 1025
    smtp_user = ENV['SMTP_USERNAME']
    smtp_pass = ENV['SMTP_PASSWORD']

    Pony.options = {
      via: :smtp,
      via_options: {
        address: smtp_host,
        port: smtp_port,
        user_name: smtp_user,
        password: smtp_pass
      }
    }

  end

  configure :development do
    enable :logging, :dump_errors, :raise_errors
  end

  configure :staging do
    enable :logging, :dump_errors, :raise_errors
  end

  configure :production do
    set :raise_errors, false
    set :show_exceptions, false
  end

end

require_relative 'helpers/init'
require_relative 'routes/init'
