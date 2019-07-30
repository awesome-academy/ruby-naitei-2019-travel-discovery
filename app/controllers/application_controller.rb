class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t("flash.danger.require_login_message")
  end

  def verify_admin!
    return if current_user.admin?

    flash[:danger] = t ".admin_require"
    redirect_to root_path
  end

  def require_login
    return if logged_in?

    store_location
    flash[:danger] = t ".login_require"
    redirect_to login_url
  end
end
