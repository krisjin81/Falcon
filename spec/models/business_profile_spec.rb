# == Schema Information
#
# Table name: business_profiles
#
#  id                 :integer(4)      not null, primary key
#  affiliate_id       :integer(4)
#  business_name      :string(50)
#  business_type      :integer(1)
#  contact_first_name :string(50)
#  contact_last_name  :string(50)
#  contact_email      :string(255)
#  about              :text
#  website            :string(255)
#  country_id         :integer(4)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

require 'spec_helper'

describe BusinessProfile do
  # Fix shoulda 'Can't find first BusinessProfile' issue
  before(:each) { create(:business_profile) }

  # Validation
  it { should validate_presence_of(:business_name) }
  it { should validate_uniqueness_of(:business_name) }
  it { should ensure_length_of(:business_name).is_at_most(50) }
  it { should validate_presence_of(:business_type) }
  it { should validate_presence_of(:style_ids) }
  it { should validate_presence_of(:audience_ids) }
  it { should validate_presence_of(:age_group_ids) }
  it { should validate_presence_of(:contact_first_name) }
  it { should ensure_length_of(:contact_first_name).is_at_most(50) }
  it { should validate_presence_of(:contact_last_name) }
  it { should ensure_length_of(:contact_last_name).is_at_most(50) }
  it { should validate_presence_of(:contact_email) }
  it { should ensure_length_of(:contact_email).is_at_most(255) }
  it { should ensure_length_of(:about).is_at_most(1000) }
  it { should ensure_length_of(:website).is_at_most(255) }

  # Mass assignment
  it { should allow_mass_assignment_of(:business_name) }
  it { should allow_mass_assignment_of(:business_type) }
  it { should allow_mass_assignment_of(:style) }
  it { should allow_mass_assignment_of(:audience) }
  it { should allow_mass_assignment_of(:age_group) }
  it { should allow_mass_assignment_of(:business_type) }
  it { should allow_mass_assignment_of(:contact_first_name) }
  it { should allow_mass_assignment_of(:contact_last_name) }
  it { should allow_mass_assignment_of(:contact_email) }
  it { should allow_mass_assignment_of(:about) }
  it { should allow_mass_assignment_of(:website) }
  it { should_not allow_mass_assignment_of(:affiliate) }
  it { should_not allow_mass_assignment_of(:affiliate_id) }
  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }
end
