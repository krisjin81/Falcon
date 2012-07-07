# == Schema Information
#
# Table name: pictures
#
#  id              :integer(4)      not null, primary key
#  attachable_type :string(255)
#  attachable_id   :integer(4)
#  title           :string(255)
#  dressing_tips   :text
#  brands          :string(255)
#  cost            :string(255)
#  where_to_buy    :string(255)
#  gender          :integer(1)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  image           :string(255)
#

require 'spec_helper'

describe Picture do
  pending "add some examples to (or delete) #{__FILE__}"
end
