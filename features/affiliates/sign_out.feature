@affiliates
Feature: Affiliate sign out
  In order to protect my account from unauthorized access
  As an affiliate
  I want to be able to sign out

    Scenario: Affiliate signs out
      Given I am registered as affiliate
        And I am logged in as affiliate
      When I sign out as affiliate
      Then I should see a signed out message
      When I visit start page
      Then I should be signed out