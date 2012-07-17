module Account::ProfilesHelper

  # Determines whether profile of currently logged in account.
  #
  # @param profile [Profile] profile to check.
  #
  # @return [Boolean] true if profile is profile of currently logged in account and false otherwise.
  #
  def is_current_profile?(profile)
    profile and current_account and profile.account_id == current_account.id
  end
end
