# AddIsFinishedToQuizAttempts
class AddIsFinishedToQuizAttempts < ActiveRecord::Migration[6.0]
  def change
    add_column :quiz_attempts, :is_finished, :boolean, null: false, default: false, index: true
  end
end
