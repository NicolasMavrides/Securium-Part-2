# == Schema Information
#
# Table name: quiz_options
#
#  id                 :integer          not null, primary key
#  letter             :string
#  option             :string
#  score              :float
#  quiz_question_id   :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_quiz_options_on_quiz_question_id  (quiz_question_id)
#

# Quiz Option Record
class QuizOption < ApplicationRecord
  belongs_to :quiz_question, :inverse_of => :quiz_options

  def to_label
    "#{letter} - #{option}"
  end
end