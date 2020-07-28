# SherlockController
class SherlockController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @current_nav_identifier = :sherlock
  end

  def search
    username = params[:search][:username]
    unless username.empty?
      @result1 = `python3 lib/assets/python/sherlock/sherlock.py "#{username}"`

      # Formatting returned string to array
      @result2 = @result1.split('[')
      @result3 = @result2.select { |n| (n.include? '+]') ? n : nil }
      @results = @result3.map { |n| n.gsub('+]', '') }

      # Formatting array to array of hashes
      @hash_result = []
      @results.each do |r|
        site_name, link = r.split(': ')
        site = { :Name => site_name, :Link => link }
        @hash_result << site
      end
    end

    @current_nav_identifier = :sherlock
    render :index
  end
end
