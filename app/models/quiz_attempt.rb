# == Schema Information
#
# Table name: quiz_attempts
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# Quiz Attempt Record
class QuizAttempt < ApplicationRecord
  belongs_to :user, :inverse_of => :quiz_attempts
  has_many :quiz_answers, dependent: :destroy, inverse_of: :quiz_attempt
end
