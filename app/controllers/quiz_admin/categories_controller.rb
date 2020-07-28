# Categories Controller
class QuizAdmin::CategoriesController < ApplicationController
  include DynamicRenderer

  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  def index
    respond_to do |format|
      render_dynamic 'index', '#category-content', format
      format.html { render_index }
    end
  end

  def show
    respond_to do |format|
      render_dynamic 'category', '#category-content', format
      format.html { render_index }
    end
  end

  def new
    @category ||= Category.new

    respond_to do |format|
      render_dynamic 'new', '#category-content', format
      format.html { render_index }
    end
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash.now[:notice] = 'Category created successfully'
      render_dynamic ['navbar', 'category'], ['#categories-nav', '#category-content']
    end
  end

  def update
    if @category.update(category_params)
      flash.now[:notice] = 'Category updated successfully'
      render_dynamic ['navbar', 'category'], ['#categories-nav', '#category-content']
    end
  end

  def destroy
    @category.destroy
    flash.now[:notice] = 'Category destroyed successfully'
    render_dynamic ['navbar', 'index'], ['#categories-nav', '#category-content']
  end

  def update_difficulty
    percent = params[:difficulty][:percent].to_f
    if (percent > 100) || percent.negative?
      redirect_to categories_path, alert: 'Difficulty must be between 0 and 100'
    else
      ENV['QUIZ_DIFFICULTY'] = params[:difficulty][:percent]
      redirect_to categories_path, notice: 'Difficulty updated successfully'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  def render_index
    @categories = Category.all.includes(:quiz_questions).order('name ASC')
    render :index
  end

  # Only allow a trusted parameter "white list" through.
  def category_params
    params.require(:category).permit(:name)
  end
end
