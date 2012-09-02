# == Schema Information
#
# Table name: likes
#
#  id            :integer(4)      not null, primary key
#  profile_id    :integer(4)
#  likeable_id   :integer(4)
#  likeable_type :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class Like < ActiveRecord::Base
  attr_accessible []

  attr_accessor :likes_count

  belongs_to :profile
  belongs_to :likeable, :polymorphic => true

  validates :profile, :presence => true
  validates :likeable, :presence => true

  scope :by_profile, lambda { |profile| where(:profile_id => profile.id) }
  scope :by_likeable, lambda { |likeable|
    if likeable.is_a?(Array)
      likeable_id = likeable.map(&:id)
      likeable_type = likeable.first.class
    else
      likeable_id = likeable.id
      likeable_type = likeable.class
    end
    where(:likeable_id => likeable_id, :likeable_type => likeable_type)
  }

  class << self

    # Creates account's like if it doesn't exist yet.
    #
    # @param profile [Profile] account profile.
    # @param likeable [ActiveRecord::Base] likeable model.
    #
    # @return [Like] just created or already existing like for profile and likeable object specified.
    #
    def track(profile, likeable)
      like_scope = self.by_profile(profile).by_likeable(likeable)
      like_scope.first || like_scope.create
    end

    # Gets count of like for likeable object or list of objects.
    #
    # @param likeable [ActiveRecord::Base or Array] likeable model or list of likeable objects.
    #
    # @return [Fixnum or Hash] count of like for likeable object or hash if list was passed to likeable.
    #
    def count_on(likeable)
      if likeable.is_a?(Array)
        likes = self.by_likeable(likeable).select("likeable_id, count(*) as likes_count").group(:likeable_id).all
        likes.inject({}) do |memo, like|
          memo[like.likeable_id] = like.attributes["likes_count"].to_i
          memo
        end
      else
        self.by_likeable(likeable).count
      end
    end

    # Detects whether likeable object was likes by particular account.
    #
    # @param profile [Profile] account profile.
    # @param likeable [ActiveRecord::Base or Array] likeable model or list of likeable objects.
    #
    # @return [Like or Hash] like or hash if list was passed to likeable.
    #
    def liked_by(profile, likeable)
      if likeable.is_a?(Array)
        self.by_profile(profile).by_likeable(likeable).index_by(&:likeable_id)
      else
        self.by_profile(profile).by_likeable(likeable).first
      end
    end
  end
end
