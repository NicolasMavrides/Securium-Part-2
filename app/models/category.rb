# == Schema Information
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  name              :string
#  easy_max_score    :float            default: 0
#  hard_max_score    :float            default: 0
#  total_max_score   :float            default: 0
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

# Category Record
class Category < ApplicationRecord
  has_many :recommendations, dependent: :destroy, inverse_of: :category
  has_many :quiz_answers, dependent: :destroy, inverse_of: :category
  has_many :quiz_questions, dependent: :destroy, inverse_of: :category
end