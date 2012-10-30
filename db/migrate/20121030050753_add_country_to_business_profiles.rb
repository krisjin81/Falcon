class AddCountryToBusinessProfiles < ActiveRecord::Migration
  def change
    add_column :business_profiles, :country, :string
  end
end
