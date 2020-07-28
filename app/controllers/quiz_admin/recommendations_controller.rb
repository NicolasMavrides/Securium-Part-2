# RecommendationsController
class QuizAdmin::RecommendationsController < ApplicationController
  include DynamicRenderer

  before_action :authenticate_admin!
  before_action :set_resources, except: [:difficulties]

  # GET categories/recommendations
  def index
    respond_to do |format|
      render_dynamic 'index', '#recommendations-content', format
      format.html { render :index }
    end
  end

  def difficulties
    @category = Category.find(params[:id])

    respond_to do |format|
      render_dynamic 'difficulties', '#difficulties-content', format
      format.html { render :index }
    end
  end

  # GET category/1/recommendations/1
  def show
    prev = Recommendation.find_previous @recommendation
    @prev_percentage = prev.percentage if prev
    respond_to do |format|
      render_dynamic 'show', '#recommendation-content', format
      format.html { render :index }
    end
  end

  # GET /recommendations/new
  def new
    @form_url = category_recommendations_path(@category, difficulty: params[:difficulty])
    @recommendation = Recommendation.new
    respond_to do |format|
      render_dynamic 'new', '#recommendation-content', format
      format.html { render :index }
    end
  end

  # GET /recommendations/1/edit
  def edit
    @form_url = category_recommendation_path(@category, @recommendation, difficulty: params[:difficulty])
    respond_to do |format|
      render_dynamic 'edit', '#recommendation-content', format
      format.html { render :index }
    end
  end

  # POST /recommendations
  def create
    @recommendation = Recommendation.new(recommendation_params)

    if @recommendation.save
      flash.now[:notice] = 'The recommendation has been created successfully.'
      render_dynamic 'index', '#recommendations-content'
    else
      render_dynamic 'new', '#recommendation-content'
    end
  end

  # PATCH/PUT /recommendations/1
  def update
    if @recommendation.update(recommendation_params)
      flash.now[:notice] = 'The recommendation has been updated successfully.'
      render_dynamic 'index', '#recommendations-content'
    else
      render_dynamic 'edit', '#recommendation-content'
    end
  end

  # DELETE /recommendations/1
  def destroy
    @recommendation.destroy
    flash.now[:notice] = 'The recommendation has been removed successfully.'
    render_dynamic 'index', '#recommendations-content'
  end

  private

  def set_resources
    @category = Category.find(params[:category_id]) if params[:category_id].present?
    @recommendations = Recommendation.where(category_id: params[:category_id], difficulty: params[:difficulty]).order(:percentage)
    @recommendation = Recommendation.find(params[:id]) if params[:id].present?
    raise ActiveRecord::RecordNotFound if @recommendation && @recommendation.difficulty != params[:difficulty].to_i
  end

  # Only allow a trusted parameter "white list" through.
  def recommendation_params
    params.require(:recommendation).permit(:percentage, :description, :category_id, :difficulty)
  end
end
