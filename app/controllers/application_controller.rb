class ApplicationController < ActionController::Base

  private

  def authenticate_user!
    redirect_to new_sessions_path unless user_signed_in?

  end
  helper_method(:authenticate_user!)

  def current_user
    if session[:user_id].present?
      @current_user ||= User.find(session[:user_id])
    end
  end
  helper_method(:current_user)

  def user_signed_in?
    current_user.present?

  end

  helper_method(:user_signed_in?)


end
