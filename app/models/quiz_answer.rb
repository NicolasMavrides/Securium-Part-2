# == Schema Information
#
# Table name: quiz_answers
#
#  id                 :integer          not null, primary key
#  quiz_question_id   :integer
#  category_id        :integer
#  quiz_attempt_id    :integer
#  letter             :string
#  option             :string
#  score              :float
#  difficult          :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_quiz_options_on_quiz_question_id  (quiz_question_id)
#  index_quiz_answers_on_quiz_option_id    (quiz_option_id)
#

# Quiz Answer Record
class QuizAnswer < ApplicationRecord
  scope :easy, -> { where(difficult: false) }
  scope :hard, -> { where(difficult: true) }

  belongs_to :quiz_attempt, :inverse_of => :quiz_answers
  belongs_to :quiz_question, :inverse_of => :quiz_answers
  belongs_to :category, :inverse_of => :quiz_answers
end