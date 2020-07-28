# Recommendation
class Recommendation < ApplicationRecord
  belongs_to :category

  validates :percentage, presence: true
  validates_uniqueness_of :percentage, scope: [:category_id, :difficulty], message: 'must be unique'
  validates_numericality_of :percentage, greater_than_or_equal_to: 1, less_than_or_equal_to: 100, message: 'must be between 1 and 100'

  def self.find_by_percentage(category_id:, difficulty:, percentage:)
    Recommendation.where(
      category_id: category_id,
      difficulty: difficulty,
      percentage: percentage..
    ).order(percentage: :asc).first
  end

  # find previous recommendation based on percentage
  def self.find_previous(recommendation)
    if recommendation
      lower_than = -Float::INFINITY..(recommendation.percentage - 1)
      Recommendation.where(
        category_id: recommendation.category_id,
        difficulty: recommendation.difficulty,
        percentage: lower_than
      ).order(percentage: :desc).first
    end
  end
end
