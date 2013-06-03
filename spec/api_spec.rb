require_relative '../app'
require_relative 'spec_helper'

include Rack::Test::Methods

describe "API" do

  describe 'GET /' do
    it 'should respond with a default page' do
      get '/'
      last_response.ok?.must_equal(true, "Response not OK")
      last_response.content_type.must_equal("text/html;charset=utf-8", "Content type is not text/html;charset=utf-8")
      last_response.body.must_match(/Relay/)
    end
  end

  describe 'POST /send' do

    it 'should respond with status 400 if params token, sender, recipients, subject or body are missing from the submission' do
      post '/send'
      last_response.status.must_equal 400, 'Expected status 400'
      last_response.body.must_match /Params token, sender, recipients, subject and body are required/
    end

    it 'should respond with status 403 if params token is invalid' do
      post '/send', params={token: 'bad_token',
                            sender: 'john@domain.com',
                            recipients: 'jane@domain.com',
                            subject: 'Test',
                            body: "Test"}
      last_response.status.must_equal 403, 'Expected status 403'
      last_response.body.must_match /Invalid token/
    end

    it 'should process a submission containing valid params' do
      post '/send', params={token: ENV['RELAY_TOKEN'],
                            sender: 'john@domain.com',
                            recipients: 'jane@domain.com',
                            subject: 'Test subject',
                            body: 'Test body',
                            body_plain: 'Test body plain'}
      last_response.status.must_equal(200, 'Expected status 200')
      last_response.content_type.must_equal("application/json", "Content type not application/json")
      last_result = JSON.parse(last_response.body)
      last_result.must_be_instance_of Hash
      last_result['sender'].must_match /john@domain.com/
      last_result['recipients'].must_match /jane@domain.com/
      last_result['subject'].must_match /Test subject/
      last_result['body'].must_match /Test body/
      last_result['body_plain'].must_match /Test body plain/
    end

    it 'should process a submission meant for multiple recipients' do
      post '/send', params={token: ENV['RELAY_TOKEN'],
                            sender: 'john@domain.com',
                            recipients: 'jane@domain.com,fred@domain.com,jack@domain.com',
                            subject: 'Test subject',
                            body: 'Test body',
                            body_plain: 'Test body plain'}
      last_response.status.must_equal(200, 'Expected status 200')
      last_response.content_type.must_equal("application/json", "Content type not application/json")
      last_result = JSON.parse(last_response.body)
      last_result.must_be_instance_of Hash
      last_result['sender'].must_match /john@domain.com/
      last_result['recipients'].must_match /jane@domain.com,fred@domain.com,jack@domain.com/
      last_result['subject'].must_match /Test subject/
      last_result['body'].must_match /Test body/
      last_result['body_plain'].must_match /Test body plain/
    end

  end

end
