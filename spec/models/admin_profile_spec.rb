# == Schema Information
#
# Table name: admin_profiles
#
#  id         :integer(4)      not null, primary key
#  admin_id   :integer(4)
#  username   :string(50)
#  first_name :string(50)
#  last_name  :string(50)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe AdminProfile do
  pending "add some examples to (or delete) #{__FILE__}"
end
