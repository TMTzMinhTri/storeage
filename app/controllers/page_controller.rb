# frozen_string_literal: true

class PageController < ApplicationController
  # before_action :authenticate_user!

  def index
    @title = "Home"
    @pagy, @borrowers = pagy(Borrower.for_listing)
  end

  def contact
    @title = "Contact"
  end
end
