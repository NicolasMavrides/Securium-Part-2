namespace :custom do
  if Rails.env.development?
    desc "Create test categories, questions and options"
    # Creates a number of categories with questions (easy & hard) and options

    task :fill_db, [:categories, :questions, :options] => :environment do |t, args|
      for i in 1..args[:categories].to_i do
        category = Category.new
        category.name = "New Cat - #{i}"
        category.easy_max_score = (args[:questions].to_i) /2
        category.hard_max_score = (args[:questions].to_i) /2
        category.total_max_score = args[:questions].to_i 
        category.save!
        for j in 1..args[:questions].to_i do
          question = QuizQuestion.new
          question.question = "Question - #{j}"
          question.active = true
          if j<= (args[:questions].to_i/2)
            question.difficult = true
          else
            question.difficult = false
          end
          question.multiple_select = false
          question.category_id = category.id
          question.max_score = 1
          question.save!
          for k in 1..args[:options].to_i do
            option = QuizOption.new
            option.letter = (k+64).chr
            option.option = "Option - #{k}"
            option.score = 1
            option.quiz_question_id = question.id
            option.save!
          end
        end
      end
      puts "#{args[:categories]} Categories Created, with #{args[:questions]} Questions and #{args[:options]} Options"
    end

    desc "Create quiz attempts"
    # Creates a number og quiz attempts
    task :fill_attempts, [:attempts] => :environment do |t, args|
      for i in 1..args[:attempts].to_i do
        attempt = QuizAttempt.new
        attempt.user_id = User.first.id
        attempt.save!
        categories = Category.all
        questions = QuizQuestion.all
        options = QuizOption.all
        categories.each do |cat|
          cat_questions = questions.where(category_id: cat.id).order('id ASC')
          cat_questions.each do |q|
            question_options = options.where(quiz_question_id: q.id)
            random_select = rand(1..question_options.length)
            selected_option = options.where(id: random_select).first
            answer = QuizAnswer.new
            answer.category_id = cat.id
            answer.quiz_question_id = q.id
            answer.quiz_attempt_id = attempt.id
            answer.difficult = q.difficult
            answer.option = selected_option.option
            answer.letter = selected_option.letter
            answer.score = selected_option.score
            answer.save!
          end
        end
      end
      puts "#{args[:attempts]} Attempts created"
    end
  end
end
