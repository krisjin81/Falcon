# == Schema Information
#
# Table name: avatars
#
#  id              :integer(4)      not null, primary key
#  attachable_type :string(255)
#  attachable_id   :integer(4)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  image           :string(255)
#

require 'spec_helper'

describe Avatar do
  pending "add some examples to (or delete) #{__FILE__}"
end
