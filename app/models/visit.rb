# == Schema Information
#
# Table name: visits
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  registration_id :integer
#

# Visit Record
class Visit < ApplicationRecord
  has_many :link_clicks, -> { where.not(url: nil).order(created_at: :asc) }
  belongs_to :registration, optional: true
end
