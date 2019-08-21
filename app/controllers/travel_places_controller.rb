class TravelPlacesController < ApplicationController
  def index
    @travel_places = TravelPlace.order_by_name(:name).search_by_name "%#{params[:term]}%"
    render json: @travel_places.map{|f| {id: f.id, value: f.name, city_name: f.city_name}}
  end

  def list_place
    @travel_places = TravelPlace.get_type(params[:id]).page(params[:page]).per Settings.num_feeds_per_page
  end
end
