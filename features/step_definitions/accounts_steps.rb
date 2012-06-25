Given /^I am registered as free member account$/ do
  @account = create(:account)
end

Given /^I am not registered as free member account$/ do
  @account = build(:account)
  User.where(:email => @account.email).delete_all
end

Given /^I am not logged in$/ do
  sign_out
end

Given /^I am logged in$/ do
  @account = create(:account)
  sign_in(@account.email, @account.password)
end

When /^I sign up with valid details"$/ do
  @account = build(:account)
  visit new_account_registration_path
  sign_up(@account)
end

When /^I sign up with "([^"]*)" and "([^"]*)"$/ do |email, password|
  @account = build(:account, :email => email, :password => password)
  visit new_account_registration_path
  sign_up(@account)
end

When /^I sign in with "([^"]*)" and "([^"]*)"$/ do |email, password|
  sign_in(email, password)
end

When /^I sign in with valid credentials$/ do
  sign_in(@account.email, @account.password)
end

When /^I sign in with a wrong password$/ do
  sign_in(@account.email, @account.password * 2)
end

When /^I sign out$/ do
  sign_out
end

When /^I ask to send me reset password instruction$/ do
  visit new_account_password_path
  within("form#new_password") do
    fill_in "account_email", :with => @account.email
    click_button "Send"
  end
end

When /^I set new password$/ do
  @new_password = Forgery(:basic).password
  within("form#edit_password") do
    fill_in "account_password", :with => @new_password
    click_button "Change"
  end
end

When /^I use random token to reset password$/ do
  visit edit_account_password_path(:reset_password_token => Forgery(:basic).encrypt)
end

When /^I visit change password page$/ do
  visit edit_account_registration_path
end

When /^I change my password$/ do
  @password = @account.password
  @new_password = Forgery(:basic).password
  within("form#change_password") do
    fill_in "account_password", :with => @new_password
    fill_in "account_current_password", :with => @password
    click_button "Update"
  end
end

When /^I change password without providing current password$/ do
  @new_password = Forgery(:basic).password
  within("form#change_password") do
    fill_in "account_password", :with => @new_password
    click_button "Update"
  end
end

When /^I change password with and provide incorrect current password$/ do
  @password = Forgery(:basic).password
  @new_password = Forgery(:basic).password
  within("form#change_password") do
    fill_in "account_password", :with => @new_password
    fill_in "account_current_password", :with => @password
    click_button "Update"
  end
end

Then /^Free member account should be created for "(.*?)"$/ do |email|
  @account = Account.find_by_email(email)
  @account.should_not be_nil
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "You have signed up successfully"
end

Then /^I should see a successful sign in message$/ do
  page.should have_content "Signed in successfully"
end

Then /^I should see an invalid sign in message$/ do
  page.should have_content "Invalid email or password"
end

Then /^I should see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account"
end

Then /^I should see a successfully confirmed message$/ do
  page.should have_content "Your account was successfully confirmed"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign in"
  page.should_not have_content "Sign out"
end

Then /^I should be signed in$/ do
  page.should_not have_content "Sign in"
  page.should have_content "Sign out"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out"
end

Then /^I should see reset password link in email body$/ do
  current_email.default_part_body.to_s.should include(edit_account_password_url(:reset_password_token => @account.reset_password_token))
end

Then /^I should see change password page$/ do
  page.should have_content "Change Password"
end

Then /^I should see password changed message$/ do
  page.should have_content "Your password was changed successfully"
end

Then /^I should see incorrect token message$/ do
  page.should have_content "Reset password token is invalid"
end

Then /^I should see account updated message$/ do
  page.should have_content "You updated your account successfully"
end

Then /^I sign in with new password/ do
  sign_in(@account.email, @new_password)
end

Then /^I should see required current password message$/ do
  page.should have_content "can't be blank"
end

Then /^I should see incorrect current password message$/ do
  page.should have_content "is invalid"
end

Then /^I should see account deleted message$/ do
  page.should have_content "Your account was successfully cancelled"
end

def sign_in(email, password)
  visit new_account_session_path
  within("form#sign_in") do
    fill_in "account_email", :with => email
    fill_in "account_password", :with => password
    click_button "Sign in"
  end
end

def sign_up(account)
  Account.any_instance.stub(:bypass_humanizer).and_return(:true)

  within("form#sign_up") do
    fill_in "account_email", :with => account.email
    fill_in "account_password", :with => account.password
    select account.profile.country.name, :from => "account_profile_attributes_country_id"
    select account.profile.birth_date.year.to_s, :from => "account_profile_attributes_birth_date_1i"
    select I18n.t("date.month_names")[account.profile.birth_date.month], :from => "account_profile_attributes_birth_date_2i"
    select account.profile.birth_date.day.to_s, :from => "account_profile_attributes_birth_date_3i"
    click_button "Sign up"
  end
end

def sign_out
  visit destroy_account_session_path
end