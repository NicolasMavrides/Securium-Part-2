# CreateRecommendations
class CreateRecommendations < ActiveRecord::Migration[6.0]
  def change
    create_table :recommendations do |t|
      t.belongs_to :category

      t.integer :percentage,     null: false
      t.string  :description,    null: false, default: ''

      t.timestamps
    end

    add_index :recommendations, :percentage, unique: true
  end
end
