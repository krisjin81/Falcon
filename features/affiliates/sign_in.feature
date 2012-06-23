@affiliates
Feature: Affiliate sign in
  In order to get access to protected sections of the site
  As an affiliate
  I want to be able to sign in

  Background:
    Given I am not logged in as affiliate

    Scenario: Affiliate signs in successfully with valid credentials
      Given I am registered as affiliate
       When I sign in as affiliate with valid credentials
       Then I should see a successful sign in message
       When I visit start page
       Then I should be signed in

    Scenario: Affiliate is not signed up
      Given I am not registered as affiliate
       When I sign in as affiliate with valid credentials
       Then I should see an invalid sign in message
        And I should be signed out

    Scenario: Affiliate enters wrong password
      Given I am registered as affiliate
       When I sign in as affiliate with a wrong password
       Then I should see an invalid sign in message
        And I should be signed out