# == Schema Information
#
# Table name: audiences
#
#  id         :integer(4)      not null, primary key
#  name       :string(50)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Audience < ActiveRecord::Base
  has_and_belongs_to_many :business_profiles, :join_table => :business_profiles_audiences

  attr_accessible :name

  after_save :clear_cache
  after_destroy :clear_cache

  class << self
    # Gets all audiences cached.
    #
    def cached
      Rails.cache.fetch(cache_key) do
        all
      end
    end

    # Clears audiences cache.
    #
    def clear_cache
      Rails.cache.delete(cache_key)
    end

    private

    def cache_key
      "audiences"
    end
  end

  private

  def clear_cache
    self.class.clear_cache
  end
end
