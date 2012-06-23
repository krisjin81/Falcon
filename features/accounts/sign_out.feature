Feature: Sign out
  In order to protect my account from unauthorized access
  As a signed in user
  I want to be able to sign out

    Scenario: User signs out
      Given I have registered account
        And I am logged in
      When I sign out
      Then I should see a signed out message
      When I visit start page
      Then I should be signed out