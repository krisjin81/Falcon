# == Schema Information
#
# Table name: pictures
#
#  id                 :integer(4)      not null, primary key
#  image_file_name    :string(255)
#  image_file_size    :integer(4)
#  image_content_type :string(255)
#  image_updated_at   :datetime
#  attachable_type    :string(255)
#  attachable_id      :integer(4)
#  title              :string(255)
#  dressing_tips      :text
#  brands             :string(255)
#  cost               :string(255)
#  where_to_buy       :string(255)
#  gender             :integer(1)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

require 'spec_helper'

describe Picture do
  pending "add some examples to (or delete) #{__FILE__}"
end
