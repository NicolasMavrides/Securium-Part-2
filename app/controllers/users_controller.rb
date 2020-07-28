# UsersController
class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:change_password]

  def index
    @users = User.all
  end

  def show
    @current_nav_identifier = :account

    @user = User.find(params[:id])
    redirect_to :back, :alert => 'Access denied.' unless @user == current_user
  end
end
