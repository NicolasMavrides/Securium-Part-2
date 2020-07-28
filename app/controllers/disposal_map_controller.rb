# DisposalMapController
class DisposalMapController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @current_nav_identifier = :disposal_map
    if @default_latlng.nil?
      @default_latlng = '54.21036, -4.5436'
      @default_zoom = '6'
    end
  end

  def search
    location = params[:map_search][:location]
    result = Geocoder.search(location).first.coordinates
    respond_to do |format|
      format.js { render :js => "updateMap2(#{result[0]}, #{result[1]});" }
    end
  end
end
