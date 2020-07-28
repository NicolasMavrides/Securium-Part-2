# CreateQuizQuestions
class CreateQuizQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_questions do |t|
      t.string :question
      t.boolean :active
      t.boolean :difficult
      t.boolean :multiple_select
      t.integer :category_id

      t.index [:category_id], name: 'index_quiz_questions_on_category_id'
      t.timestamps
    end
  end
end
