# CreateQuizAnswers
class CreateQuizAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_answers do |t|
      t.integer :quiz_question_id
      t.integer :category_id
      t.integer :quiz_attempt_id
      t.string :letter
      t.string :option
      t.float :score
      t.boolean :difficult

      t.index [:quiz_question_id], name: 'index_quiz_answers_on_quiz_question_id'
      t.index [:category_id], name: 'index_quiz_answers_on_category_id'
      t.index [:quiz_attempt_id], name: 'index_quiz_answers_on_quiz_attmept_id'
    end
  end
end
