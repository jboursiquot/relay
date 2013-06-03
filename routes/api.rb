# encoding: utf-8
class App < Sinatra::Application

  error do
    status 500
    headers 'Content-Type' => 'text/plain'
    "Internal Error: #{env['sinatra.error']}"
  end 

  not_found do
    "Not Found"
  end

  get '/' do
    'Relay'
  end

  post '/send' do

    if (params[:token].nil? || params[:sender].nil? || params[:recipient].nil? || params[:subject].nil? || params[:body].nil?)
      halt 400, {'Content-Type' => 'text/plain'}, 'Params token, sender, recipient, subject and body are required'
    end

    if (!params[:token].eql? settings.valid_token)
      halt 403, {'Content-Type' => 'text/plain'}, 'Invalid token'
    end

    params.each_pair {|k, v| v.strip!}

    sender = params[:sender];
    recipient = params[:recipient]
    subject = params[:subject]
    body = params[:body]
    body_plain = params[:body_plain] unless params[:body_plain].nil?

    Mailer.send sender, recipient, subject, body, body_plain

    status 200
    headers 'Content-Type' => 'application/json'
    params.to_json

  end

end
