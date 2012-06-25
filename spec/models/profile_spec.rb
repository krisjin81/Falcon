# == Schema Information
#
# Table name: profiles
#
#  id         :integer(4)      not null, primary key
#  account_id :integer(4)
#  username   :string(50)
#  first_name :string(50)
#  last_name  :string(50)
#  birth_date :date
#  country_id :integer(4)
#  gender     :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Profile do
  pending "add some examples to (or delete) #{__FILE__}"
end
