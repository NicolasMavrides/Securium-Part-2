# CreateQuizAttempts
class CreateQuizAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_attempts do |t|
      t.integer :user_id

      t.index [:user_id], name: 'index_quiz_attempts_on_user_id'
      t.timestamps
    end
  end
end
