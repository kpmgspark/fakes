require 'fakes/oauth/emma/emma_fake_api'
require 'fakes/oauth/eventbrite/eventbrite_fake_api'

module Fakes
  class OAuthFake < Sinatra::Base
    register FakeEmmaApi
    register FakeEventbriteApi

    # fake token
    post '/oauth/:service/token' do
      json_response 200, 'access_token.json', params[:service]
    end

    # auth
    get '/oauth/:service' do
      redirect params[:redirect_uri]
    end

    private

    def json_response(response_code, file_name, service)
      content_type :json
      status response_code
      File.open(File.dirname(__FILE__) +"/oauth/#{service}/#{service}_data/" + file_name, 'rb').read
    end
  end
end