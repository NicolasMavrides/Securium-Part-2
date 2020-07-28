# Breaches Controller
class BreachesController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @current_nav_identifier = :breaches
    render :index
  end

  def search
    @email_addr = params[:search][:email]
    @search_performed = true # indicate user has performed search_performed

    # Create Faraday connection object
    conn = Faraday.new(
      url: "https://haveibeenpwned.com/api/v3/breachedaccount/#{@email_addr}",
      params: { truncateResponse: false },
      headers: { 'user-agent' => Rails.application.secrets.user_agent,
                 'hibp-api-key' => Rails.application.secrets.hibp_api_key }
    )

    # execute GET request
    resp = conn.get("https://haveibeenpwned.com/api/v3/breachedaccount/#{@email_addr}")

    # if an email isn't involved in a breach then response body will be empty
    # thus parse only if the resp.body isn't empty
    if resp.body != ''
      # parse the breach data as a JSON array
      @breach_data = JSON.parse(resp.body)
      # otherwise email isn't involved in breach so no need to parse anything.
      # just render the good news.
    end

    render :index
  end
end
