module Account::ProfilesHelper
  def is_current_profile?(profile)
    profile and current_account and profile.account_id == current_account.id
  end
end
