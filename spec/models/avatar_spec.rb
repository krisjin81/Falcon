# == Schema Information
#
# Table name: avatars
#
#  id                 :integer(4)      not null, primary key
#  image_file_name    :string(255)
#  image_file_size    :integer(4)
#  image_content_type :string(255)
#  image_updated_at   :datetime
#  attachable_type    :string(255)
#  attachable_id      :integer(4)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

require 'spec_helper'

describe Avatar do
  pending "add some examples to (or delete) #{__FILE__}"
end
