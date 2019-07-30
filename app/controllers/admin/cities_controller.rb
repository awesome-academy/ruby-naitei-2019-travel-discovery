class Admin::CitiesController < ApplicationController
  protect_from_forgery prepend: true, with: :exception
  skip_before_action :verify_authenticity_token
  before_action :load_city, only: %i(show edit update destroy)

  layout "admin"

  def index
    @cities = City.all.page(params[:page]).per Settings.item_page
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new city_params
    respond_to do |format|
      if @city.save
        format.html{redirect_to admin_cities_path}
        format.js
      else
        flash[:danger] = t ".add_fails"
        redirect_to admin_cities_path
      end
    end
  end

  def edit
    respond_to do |format|
      format.json{render json: @city.to_json}
    end
  end

  def update
    respond_to do |format|
      if @city.update_attributes city_params
        format.html{redirect_to admin_cities_path}
        format.js
      else
        flash[:danger] = t ".edit_fails"
        redirect_to admin_cities_path
      end
    end
  end

  def destroy
    return unless @city.destroy
    flash[:danger] = t ".dele_fails"
    redirect_to admin_cities_path
  end

  private

  def city_params
    params.permit :name
  end

  def load_city
    @city = City.find_by id: params[:id]
    return if @city
    flash[:danger] = t ".danger"
    redirect_to admin_root_path
  end
end
