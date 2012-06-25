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

  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 50 }
  validates :iso2, :length => { :maximum => 2 }, :allow_blank => true
  validates :iso3, :length => { :maximum => 3 }, :allow_blank => true

  after_save :clear_cache
  after_destroy :clear_cache

  class << self
    # Gets all countries cached.
    #
    def cached
      Rails.cache.fetch(cache_key) do
        all
      end
    end

    # Clears countries cache.
    #
    def clear_cache
      Rails.cache.delete(cache_key)
    end

    private

    def cache_key
      "countries"
    end
  end

  private

  def clear_cache
    self.class.clear_cache
  end
end
