# Quiz Questions Controller
class QuizAdmin::QuizQuestionsController < ApplicationController
  include DynamicRenderer

  before_action :authenticate_admin!
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def show
    @category = Category.find(params[:category_id])

    respond_to do |format|
      render_dynamic 'show', "#question-#{params[:id]}-content", format
      format.html { render 'categories/index' }
    end
  end

  def new
    @category = Category.find(params[:category_id])
    @question = QuizQuestion.new

    respond_to do |format|
      render_dynamic 'new', '#questions-content', format
      format.html { render 'categories/index' }
    end
  end

  def edit
    @category = Category.find(@question.category_id)

    respond_to do |format|
      render_dynamic 'edit', '#questions-content', format
      format.html { render 'categories/index' }
    end
  end

  def create
    @question = QuizQuestion.new(question_params)
    if @question.save
      update_categories_max_score

      flash.now[:notice] = 'Quiz question was successfully created.'
      render_dynamic ['quiz_admin/categories/navbar', 'quiz_admin/categories/category'], ['#categories-nav', '#category-content']
    else
      render_dynamic 'edit', '#questions-content'
    end
  end

  def update
    if @question.update(question_params)
      update_categories_max_score

      flash.now[:notice] = 'Quiz question was successfully updated.'
      render_dynamic ['quiz_admin/categories/navbar', 'quiz_admin/categories/category'], ['#categories-nav', '#category-content']
    else
      render_dynamic 'edit', '#questions-content'
    end
  end

  def destroy
    @question.destroy

    update_categories_max_score

    flash.now[:notice] = 'Quiz question was successfully deleted.'
    render_dynamic 'quiz_admin/categories/category', '#category-content'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = QuizQuestion.find(params[:id])
    @cat = @question.category
  end

  # Only allow a trusted parameter "white list" through.
  def question_params
    params.require(:quiz_question).permit(:question, :active, :difficult, :multiple_select, :category_id)
  end

  def update_categories_max_score
    cat = @question.category || @cat
    cat_easy_questions = QuizQuestion.easy.where category_id: cat.id
    cat_hard_questions = QuizQuestion.hard.where category_id: cat.id
    easy_score = cat_easy_questions.sum(:max_score)
    hard_score = cat_hard_questions.sum(:max_score)
    cat.update(easy_max_score: easy_score)
    cat.update(hard_max_score: hard_score)
    cat.update(total_max_score: (easy_score + hard_score))
    @category = cat
  end
end
