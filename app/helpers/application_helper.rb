module ApplicationHelper
  # Gets currently logged in account or affiliate.
  #
  # @return [User] account or affiliate.
  #
  def current_user
    User::TYPES.each do |mapping|
      user = self.send("current_#{mapping.to_s.downcase}")
      return user unless user.nil?
    end
  end

  # Determines whether account or affiliate is logged in.
  #
  # @return [Boolean] true if account or affiliate is logged in and false otherwise.
  #
  def user_signed_in?
    !!current_user
  end

  # Gets currently logged in user type (account, affiliate, guest).
  #
  # @return [Symbol] :account, :affiliate or :guest symbol.
  #
  def current_user_type
    User::TYPES.each do |mapping|
      user = send("current_#{mapping.to_s.downcase}")
      return mapping unless user.nil?
    end
    :guest
  end
end
