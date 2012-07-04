module ActiveRecordExtensions
  extend ActiveSupport::Concern

  module ClassMethods
    # Gets random record.
    #
    def random
      offset(rand(count)).first
    end
  end
end