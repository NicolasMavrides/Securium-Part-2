# AddMaxScore
class AddMaxScore < ActiveRecord::Migration[6.0]
  def change
    add_column :quiz_questions, :max_score, :float, default: 0
    add_column :categories, :easy_max_score, :float, default: 0
    add_column :categories, :hard_max_score, :float, default: 0
    add_column :categories, :total_max_score, :float, default: 0
  end
end
