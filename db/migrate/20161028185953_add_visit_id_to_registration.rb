# AddVisitIdToRegistration
class AddVisitIdToRegistration < ActiveRecord::Migration[5.0]
  def change
    add_column :visits, :registration_id, :integer, index: true
  end
end
