# Quiz Controller
class QuizController < ApplicationController
  before_action :current_question, only: [:question, :next]
  before_action :authenticate_user!, only: [:start, :question, :results]
  @@categories = Category.all.order(name: :asc)

  def start
    current_quiz_attempt if user_signed_in?
    @current_nav_identifier = :quiz_start
    current_category
    @text = 'Begin'
    if session[:current_cat] > 1 || (session[:current_question] && session[:current_question].positive?) || session[:hard_questions]
      @text = 'Continue'
    end
  end

  def question
    questions = session[:questions].includes(:category)
    @question = questions[@current_question]
    @last = false
    @last = true if questions[(@current_question + 1)].nil?
    @category_id = @@categories[session[:current_cat] - 1].id
    @answer = QuizAnswer.new
    @categories = @@categories
  end

  def next
    count = 0
    @last = false
    questions = session[:questions]
    @last = true if questions[(@current_question + 1)].nil?

    if params[:quiz_answer][:option].is_a? String
      selected = QuizOption.where(id: params[:quiz_answer][:option])[0]
      params[:answer] = {}
      params[:answer][:category_id] = params[:quiz_answer][:category_id]
      params[:answer][:difficult] = params[:quiz_answer][:difficult]
      params[:answer][:quiz_question_id] = params[:quiz_answer][:quiz_question_id]
      params[:answer][:option] = selected.option
      params[:answer][:letter] = selected.letter
      params[:answer][:score] = selected.score
      params[:answer][:quiz_attempt_id] = session[:current_quiz_attempt]
      answer = QuizAnswer.new(answers_params(params[:answer]))
      update_score(selected.score) if answer.save
    else
      no_empty_options = params[:quiz_answer][:option].reject { |c| c.empty? }
      no_empty_options.each do |p|
        selected = QuizOption.where(id: p)[0]
        params[:answer] = {}
        params[:answer][:category_id] = params[:quiz_answer][:category_id]
        params[:answer][:difficult] = params[:quiz_answer][:difficult]
        params[:answer][:quiz_question_id] = params[:quiz_answer][:quiz_question_id]
        params[:answer][:option] = selected.option
        params[:answer][:letter] = selected.letter
        params[:answer][:score] = selected.score
        params[:answer][:quiz_attempt_id] = session[:current_quiz_attempt]
        answer = QuizAnswer.new(answers_params(params[:answer]))

        if answer.save
          count += 1
          update_score(selected.score)
        else
          break
        end
      end
    end

    if @last
      end_category
    elsif (no_empty_options && count == no_empty_options.length) || (params[:quiz_answer][:option].is_a? String)
      update_current_question
      redirect_to question_path, notice: 'Answer was saved'
    else
      redirect_to question_path :question, notice: 'Answer was not saved'
    end
  end

  # Quiz Results
  def end_category
    @hard_questions = QuizQuestion.hard.where(category_id: session[:current_cat])
    if !@@categories[session[:current_cat]].nil?
      if !session[:hard_questions] && (category_score > ENV['QUIZ_DIFFICULTY'].to_f) && !@hard_questions.empty?
        increase_difficulty(@hard_questions)
      else
        update_current_category
      end
      redirect_to question_path, notice: 'Answer was saved'
    elsif !session[:hard_questions] && (category_score > ENV['QUIZ_DIFFICULTY'].to_f) && !@hard_questions.empty?
      increase_difficulty(@hard_questions)
      redirect_to question_path, notice: 'Answer was saved'
    else
      redirect_to end_quiz_path, notice: 'Quiz Complete'
    end
  end

  # Results page
  def end_quiz
    @current_nav_identifier = :quiz_start
    session.delete(:current_cat)
    session.delete(:current_score)
    session.delete(:current_question)
    session.delete(:hard_questions)
    session.delete(:questions)
    session[:quiz_complete] = true

    @categories = Category.all.order('name ASC')

    attempt = QuizAttempt.where(id: session[:current_quiz_attempt])[0]
    attempt.is_finished = true
    attempt.save!

    @answers = attempt.quiz_answers
  end

  def results
    @quiz_attempts = current_user.quiz_attempts.where(is_finished: true).order(id: :desc)
  end

  private

  def current_quiz_attempt
    if session[:quiz_complete]
      session[:quiz_complete] = false
      session.delete(:current_quiz_attempt)
    end
    @current_quiz_attempt = QuizAttempt.find_by(id: session[:current_quiz_attempt]) || QuizAttempt.create(user_id: current_user.id)
    session[:current_quiz_attempt] = @current_quiz_attempt.id
  end

  def current_question
    @current_question = session[:current_question] || 0
    session[:current_question] = @current_question
    @current_score = session[:current_score] || 0
    session[:current_score] = @current_score
  end

  def current_category
    current_cat = session[:current_cat] || 1
    session[:current_cat] = current_cat
    session[:questions] = QuizQuestion.easy.where(category_id: current_cat).includes(:quiz_options).order('id ASC')
  end

  def update_current_question
    session[:current_question] += 1
  end

  def update_current_category
    session[:current_cat] += 1
    session[:current_score] = 0
    session[:current_question] = 0
    session[:hard_questions] = false
    current_category
  end

  def reset
    session.delete(:current_cat)
    session.delete(:current_score)
    session.delete(:current_question)
    session.delete(:hard_questions)
    session.delete(:questions)
    session.delete(:current_quiz_attempt)
  end

  def update_score(score)
    session[:current_score] += score
  end

  def answers_params(params)
    params.permit(:letter, :option, :score, :difficult, :quiz_question_id, :quiz_attempt_id, :user_id, :category_id, :difficult)
  end

  def category_score
    easy_max = session[:questions].sum(:max_score)
    percent = ((session[:current_score] / easy_max) * 100).floor
  end

  def increase_difficulty(hard_questions)
    session[:hard_questions] = true
    session[:questions] = hard_questions
    session[:current_question] = 0
  end
end
