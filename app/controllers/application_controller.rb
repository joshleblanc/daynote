class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Authentication

  around_action :set_timezone
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def set_timezone
    if Current.user.present?
      Time.use_zone(Current.user.timezone) { yield }
    else
      Time.use_zone("UTC") { yield }
    end
  end
end
