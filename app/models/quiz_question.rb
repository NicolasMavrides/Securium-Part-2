# == Schema Information
#
# Table name: quiz_questions
#
#  id                 :integer          not null, primary key
#  question           :string
#  active             :boolean
#  difficult          :boolean
#  multiple_select    :boolean
#  max_score          :float            default: 0
#  category_id        :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_quiz_questions_on_category_id  (category_id)
#

# Quiz Question Record
class QuizQuestion < ApplicationRecord
  scope :easy, -> { where(difficult: false) }
  scope :hard, -> { where(difficult: true) }

  belongs_to :category
  has_many :quiz_options, dependent: :destroy, inverse_of: :quiz_question
  has_many :quiz_answers, dependent: :destroy, inverse_of: :quiz_question
end