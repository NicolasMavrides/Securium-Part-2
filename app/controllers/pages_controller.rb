# Pages Controller
class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:accessibility, :contact_us, :privacy]

  def home
    @current_nav_identifier = :home
  end

  def exposure
    @current_nav_identifier = :exposure
  end

end
