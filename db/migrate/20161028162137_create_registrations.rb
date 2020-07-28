# CreateRegistrations
class CreateRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :registrations do |t|
      t.string :name
      t.string :email
      t.text :extra_info

      t.timestamps
    end
  end
end
