Given /^I am registered as affiliate/ do
  @affiliate = create(:affiliate)
end

Given /^I am not registered as affiliate$/ do
  @affiliate = build(:affiliate)
  User.where(:email => @affiliate.email).delete_all
end

Given /^I am not logged in as affiliate$/ do
  affiliate_sign_out
end

Given /^I am logged in as affiliate$/ do
  @affiliate = create(:affiliate)
  affiliate_sign_in(@affiliate.email, @affiliate.password)
end

When /^I sign up as affiliate with "([^"]*)" and "([^"]*)"$/ do |email, password|
  @affiliate = build(:affiliate, :email => email, :password => password)
  visit new_affiliate_registration_path
  affiliate_sign_up(@affiliate)
end

When /^I sign in as affiliate with "([^"]*)" and "([^"]*)"$/ do |email, password|
  affiliate_sign_in(email, password)
end

When /^I sign in as affiliate with valid credentials$/ do
  affiliate_sign_in(@affiliate.email, @affiliate.password)
end

When /^I sign in as affiliate with a wrong password$/ do
  affiliate_sign_in(@affiliate.email, @affiliate.password * 2)
end

When /^I sign out as affiliate$/ do
  affiliate_sign_out
end

When /^I ask to send me reset password instruction as affiliate$/ do
  visit new_affiliate_password_path
  within("form#new_password") do
    fill_in "affiliate_email", :with => @affiliate.email
    click_button "Send"
  end
end

When /^I set new affiliate password$/ do
  @new_password = Forgery(:basic).password
  within("form#edit_password") do
    fill_in "affiliate_password", :with => @new_password
    click_button "Change"
  end
end

When /^I use random token to reset affiliate password$/ do
  visit edit_affiliate_password_path(:reset_password_token => Forgery(:basic).encrypt)
end

When /^I visit change password page as affiliate$/ do
  visit edit_affiliate_registration_path
end

When /^I change my affiliate password$/ do
  @password = @affiliate.password
  @new_password = Forgery(:basic).password
  within("form#change_password") do
    fill_in "affiliate_password", :with => @new_password
    fill_in "affiliate_current_password", :with => @password
    click_button "Update"
  end
end

When /^I change my affiliate password without providing current password/ do
  @new_password = Forgery(:basic).password
  within("form#change_password") do
    fill_in "affiliate_password", :with => @new_password
    click_button "Update"
  end
end

When /^I change my affiliate password and provide incorrect current password/ do
  @password = Forgery(:basic).password
  @new_password = Forgery(:basic).password
  within("form#change_password") do
    fill_in "affiliate_password", :with => @new_password
    fill_in "affiliate_current_password", :with => @password
    click_button "Update"
  end
end

Then /^Affiliate account should be created for "(.*?)"$/ do |email|
  @affiliate = Affiliate.find_by_email(email)
  @affiliate.should_not be_nil
end

Then /^I should see reset affiliate password link in email body$/ do
  current_email.default_part_body.to_s.should include(edit_affiliate_password_url(:reset_password_token => @affiliate.reset_password_token))
end

Then /^I sign in as affiliate with new password/ do
  affiliate_sign_in(@affiliate.email, @new_password)
end

def affiliate_sign_up(affiliate)
  Affiliate.any_instance.stub(:bypass_humanizer).and_return(:true)

  within("form#sign_up") do
    fill_in "affiliate_email", :with => affiliate.email
    fill_in "affiliate_password", :with => affiliate.password
    fill_in "affiliate_password_confirmation", :with => affiliate.password
    fill_in "affiliate_business_profile_attributes_business_name", :with => affiliate.business_profile.business_name
    fill_in "affiliate_business_profile_attributes_business_name", :with => affiliate.business_profile.business_name
    select affiliate.business_profile.business_type_humanize, :from => "affiliate_business_profile_attributes_business_type"
    affiliate.business_profile.styles.each do |style|
      check style.name
    end
    affiliate.business_profile.audiences.each do |audience|
      check audience.name
    end
    affiliate.business_profile.age_groups.each do |age_group|
      check age_group.name
    end
    fill_in "affiliate_business_profile_attributes_contact_first_name", :with => affiliate.business_profile.contact_first_name
    fill_in "affiliate_business_profile_attributes_contact_last_name", :with => affiliate.business_profile.contact_last_name
    fill_in "affiliate_business_profile_attributes_contact_email", :with => affiliate.business_profile.contact_email
    fill_in "affiliate_business_profile_attributes_about", :with => affiliate.business_profile.about
    fill_in "affiliate_business_profile_attributes_website", :with => affiliate.business_profile.website
    select affiliate.business_profile.country.name, :from => "affiliate_business_profile_attributes_country_id"
    click_button "Sign up"
  end
end

def affiliate_sign_in(email, password)
  visit new_affiliate_session_path
  within("form#sign_in") do
    fill_in "affiliate_email", :with => email
    fill_in "affiliate_password", :with => password
    click_button "Sign in"
  end
end

def affiliate_sign_out
  visit destroy_affiliate_session_path
end