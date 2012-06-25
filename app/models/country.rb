# == Schema Information
#
# Table name: countries
#
#  id   :integer(4)      not null, primary key
#  name :string(50)
#  iso2 :string(2)
#  iso3 :string(3)
#

class Country < ActiveRecord::Base
  attr_accessible :name, :iso2, :iso3
end
