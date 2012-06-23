When /^I visit start page$/ do
  visit root_path
end

Then /^I should see a "([^"]*)"$/ do |message|
  page.should have_content message
end