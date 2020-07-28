# AddDifficultyToRecommendations
class AddDifficultyToRecommendations < ActiveRecord::Migration[6.0]
  def change
    remove_index :recommendations, :percentage
    add_column :recommendations, :difficulty, :integer, null: false, default: 1
    add_index :recommendations, [:category_id, :difficulty, :percentage], unique: true, name: 'index_recommendations_on_category_difficulty_percentage'
    add_index :recommendations, [:category_id, :difficulty]
  end
end
