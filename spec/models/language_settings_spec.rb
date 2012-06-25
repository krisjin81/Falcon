# == Schema Information
#
# Table name: language_settings
#
#  id      :integer(4)      not null, primary key
#  user_id :integer(4)
#  locale  :string(255)
#

require 'spec_helper'

describe LanguageSettings do
  # Validation
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:locale) }
  it { should ensure_length_of(:locale).is_at_most(3) }

  # Mass assignment
  it { should allow_mass_assignment_of(:locale) }
  it { should_not allow_mass_assignment_of(:user) }
  it { should_not allow_mass_assignment_of(:user_id) }
end
