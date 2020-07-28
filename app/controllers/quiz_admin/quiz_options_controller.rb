# Quiz Options Controller
class QuizAdmin::QuizOptionsController < ApplicationController
  include DynamicRenderer

  before_action :authenticate_admin!
  before_action :set_option, only: [:show, :edit, :update, :destroy]
  before_action :set_resources, except: [:show]

  def index
    @options = @question.quiz_options

    respond_to do |format|
      render_dynamic 'index', "#question-#{@question.id}-content .options", format
      format.html { redirect_to category_path @category }
    end
  end

  def show
    redirect_to category_path params[:category_id]
  end

  def new
    @option = QuizOption.new

    respond_to do |format|
      render_dynamic 'new', "#question-#{@question.id}-content .options", format
      format.html { redirect_to category_path @category }
    end
  end

  def edit
    respond_to do |format|
      render_dynamic 'edit', "#question-#{@question.id}-content .options", format
      format.html { redirect_to category_path @category }
    end
  end

  def create
    @option = QuizOption.new(option_params)
    render_change 'created' if @option.save
  end

  def update
    render_change 'updated' if @option.update(option_params)
  end

  def destroy
    @option.destroy
    render_change 'deleted'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_option
    @option = QuizOption.find(params[:id])
    @q = @option.quiz_question
  end

  def set_resources
    @question = QuizQuestion.find(params[:quiz_question_id])
    @category = @question.category
  end

  def render_change(type)
    partials = ['quiz_admin/categories/category_header', 'quiz_admin/quiz_questions/show']
    selectors = ['#category-header', "#question-#{params[:quiz_question_id]}-content"]

    update_questions_max_score
    @question_expanded = true

    flash.now[:notice] = "Option was successfully #{type}."
    render_dynamic partials, selectors
  end

  # Only allow a trusted parameter "white list" through.
  def option_params
    params.require(:quiz_option).permit(:letter, :option, :score, :quiz_question_id)
  end

  def update_questions_max_score
    q = @q || @option.quiz_question
    q_options = QuizOption.where quiz_question_id: q.id
    max_score = 0
    if q.multiple_select
      max_score = q_options.sum(:score)
    else
      max_score = q_options.maximum(:score)
    end
    q.update(max_score: max_score)
    update_categories_max_score(q)
    @question = q
  end

  def update_categories_max_score(question)
    cat = question.category
    cat_easy_questions = QuizQuestion.easy.where(category_id: cat.id)
    cat_hard_questions = QuizQuestion.hard.where(category_id: cat.id)
    easy_score = cat_easy_questions.sum(:max_score)
    hard_score = cat_hard_questions.sum(:max_score)
    cat.update(easy_max_score: easy_score)
    cat.update(hard_max_score: hard_score)
    cat.update(total_max_score: (easy_score + hard_score))
    @category = cat
  end
end
