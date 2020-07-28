# Visits Controller
class VisitsController < ApplicationController
  before_action :authenticate_user!

  def index
    @visits = Visit.joins(:link_clicks).order('created_at DESC').uniq
  end

end