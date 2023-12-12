class PageController < ApplicationController
  def home; end

  def callback
    facebook_user = FacebookService::Authorize.call(code: params[:code])
    p '--------------------------------'
    p facebook_user
    p '--------------------------------'
    render json: facebook_user
    # redirect_to 'http://localhost:3002'
  end
end
