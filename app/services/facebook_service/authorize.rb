module FacebookService
  class Authorize < ApplicationService
    APP_ID = ENV['FACEBOOK_APP_ID']
    APP_SECRET = ENV['FACEBOOK_APP_SECRET']
    attr_reader :code

    def initialize(code:)
      super
      @code = code
      @oauth = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, 'http://localhost:3000/callback')
    end

    def call
      @result = @oauth.get_access_token(code)
    rescue StandardError => e
      errors_add(e.message)
    end
  end
end
