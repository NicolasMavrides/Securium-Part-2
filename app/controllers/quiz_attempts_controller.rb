# Quiz Attempts Controller
class QuizAttemptsController < ApplicationController
  before_action :set_attempt, only: [:show, :destroy]

  def index
    @attempts = QuizAttempt.all
  end

  def show
    @categories = Category.all.order(name: :asc).includes(:quiz_questions)
    render 'quiz/show_attempt'
  end

  def new
    @attempt = QuizAttempt.new
  end

  def destroy
    if session[:current_quiz_attempt] == params[:id].to_i
      session.delete(:current_cat)
      session.delete(:current_score)
      session.delete(:current_question)
      session.delete(:hard_questions)
      session.delete(:questions)
      session.delete(:current_quiz_attempt)
    end
    @attempt.destroy
    redirect_to results_path, notice: 'Quiz Attempt was successfully deleted.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attempt
    @attempt = QuizAttempt.find(params[:id])
  end
end
