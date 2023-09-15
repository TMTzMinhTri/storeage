class PageController < ApplicationController
  before_action :authenticate_user!

  def index
    @title = 'Home'
  end

  def contact
    @title = 'Contact'
  end
end
