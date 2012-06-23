@accounts
Feature: Free account member sign in
  In order to get access to protected sections of the site
  As free account member
  I want to be able to sign in

  Background:
    Given I am not logged in

    Scenario: Free account member signs in successfully with valid credentials
      Given I am registered as free member account
       When I sign in with valid credentials
       Then I should see a successful sign in message
       When I visit start page
       Then I should be signed in

    Scenario: Free account member is not signed up
      Given I am not registered as free member account
       When I sign in with valid credentials
       Then I should see an invalid sign in message
        And I should be signed out

    Scenario: Free account member enters wrong password
      Given I am registered as free member account
       When I sign in with a wrong password
       Then I should see an invalid sign in message
        And I should be signed out