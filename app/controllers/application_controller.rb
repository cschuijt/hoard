class ApplicationController < ActionController::Base
  add_flash_types :danger, :warning, :success

  def new_session_path(scope)
    new_user_session_path
  end
end
