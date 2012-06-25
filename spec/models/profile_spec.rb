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
  # Fix shoulda 'Can't find first Profile' issue
  before(:each) { create(:profile) }

  # Validation
  it { should validate_uniqueness_of(:username) }
  it { should ensure_length_of(:username).is_at_most(50) }
  it { should ensure_length_of(:first_name).is_at_most(50) }
  it { should ensure_length_of(:last_name).is_at_most(50) }
  it { should validate_presence_of(:birth_date) }
  it { should validate_presence_of(:country_id) }

  # Mass assignment
  it { should allow_mass_assignment_of(:username) }
  it { should allow_mass_assignment_of(:first_name) }
  it { should allow_mass_assignment_of(:last_name) }
  it { should allow_mass_assignment_of(:birth_date) }
  it { should allow_mass_assignment_of(:country_id) }
  it { should allow_mass_assignment_of(:gender) }
  it { should_not allow_mass_assignment_of(:account) }
  it { should_not allow_mass_assignment_of(:account_id) }
end
