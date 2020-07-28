# CreateQuizOptions
class CreateQuizOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_options do |t|
      t.string :letter
      t.string :option
      t.float :score
      t.integer :quiz_question_id

      t.index [:quiz_question_id], name: 'index_quiz_options_on_quiz_question_id'
      t.timestamps
    end
  end
end
