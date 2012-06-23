@accounts
Feature: Free account member sign out
  In order to protect my account from unauthorized access
  As free account member
  I want to be able to sign out

    Scenario: Free account member signs out
      Given I am registered as free member account
        And I am logged in
      When I sign out
      Then I should see a signed out message
      When I visit start page
      Then I should be signed out