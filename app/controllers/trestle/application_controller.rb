class Trestle::ApplicationController < ActionController::Base
  protect_from_forgery

  include Trestle::Controller::Breadcrumbs
  include Trestle::Controller::Callbacks
  include Trestle::Controller::Dialog
  include Trestle::Controller::Helpers
  include Trestle::Controller::Layout
  include Trestle::Controller::Location
  include Trestle::Controller::Title
  include Trestle::Controller::Toolbars

  around_action :set_time_zone, if: :current_user

  private

  def set_time_zone(&block)
    Time.use_zone('Hanoi', &block)
  end
end
