# == Schema Information
#
# Table name: registrations
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Registration Record
class Registration < ApplicationRecord
end
