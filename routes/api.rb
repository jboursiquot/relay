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

    if (params[:token].nil? || params[:sender].nil? || params[:recipients].nil? || params[:subject].nil? || params[:body].nil?)
      halt 400, {'Content-Type' => 'text/plain'}, 'Params token, sender, recipients, subject and body are required'
    end

    if (!params[:token].eql? settings.valid_token)
      halt 403, {'Content-Type' => 'text/plain'}, 'Invalid token'
    end

    params.each_pair {|k, v| v.strip!}

    sender = params[:sender];
    recipients = params[:recipients].split(',')
    subject = params[:subject]
    cc = params[:cc]
    body = params[:body]
    body_plain = params[:body_plain] unless params[:body_plain].nil?

    recipients.each do |recipient|
      Mailer.send sender, recipient, cc, subject, body, body_plain
    end

    status 200
    headers 'Content-Type' => 'application/json'
    params.to_json

  end

end
