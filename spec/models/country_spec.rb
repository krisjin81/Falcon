# == Schema Information
#
# Table name: countries
#
#  id   :integer(4)      not null, primary key
#  name :string(50)
#  iso2 :string(2)
#  iso3 :string(3)
#

require 'spec_helper'

describe Country do
  # Fix shoulda 'Can't find first Country' issue
  before(:each) { create(:country) }

  # Validation
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should ensure_length_of(:iso2).is_at_most(2) }
  it { should ensure_length_of(:iso3).is_at_most(3) }

  # Mass assignment
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:iso2) }
  it { should allow_mass_assignment_of(:iso3) }
end
