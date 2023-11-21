module FacebookService
  class ConnectPage < ApplicationService
    APP_ID = ENV['FACEBOOK_APP_ID']
    APP_SECRET = ENV['FACEBOOK_APP_SECRET']

    def initialize
      super
      @oauth = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, 'http://localhost:3000/users/auth/facebook/callback')
      # @user_graph = Koala::Facebook::API.new('EAAEGQ3YcMm8BO46IOZAcTSRhkamz4mM3acaNQ00MhOHtRvsC2oZBfDnZBPKppWlO1dvkKDzL2ucWlEceZAcrkqkZB14DtZAMmE0nsdeHDId4WfWWqgMfolfdD0w7K4AAwAuGs5yy4H7ZCuZBDFaCIuDp3tpXNTGANZCedOhpmhu7jhoDAHo0BzXdFw1MvmWG7LWKFGqTs3ZBDE1byxTb0hTwZDZD')
    end

    def call
      result = []

      @result = result
      # url = @oauth.url_for_oauth_code(permissions: 'public_profile,email,pages_show_list', state: Devise.friendly_token)
      # @result = url
      # url
    end
  end
end
