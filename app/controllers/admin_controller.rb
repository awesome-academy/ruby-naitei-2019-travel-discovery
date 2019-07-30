class AdminController < ApplicationController
  protect_from_forgery prepend: true, with: :exception
  before_action :require_login, :verify_admin!
  before_action :set_locale

  layout "admin"

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def index; end
end
