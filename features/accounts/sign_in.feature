Feature: Sign in
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign in

  Background:
    Given I am not logged in

    Scenario: User signs in successfully with valid credentials
      Given I have registered account
       When I sign in with valid credentials
       Then I should see a successful sign in message
       When I visit start page
       Then I should be signed in

    Scenario: User is not signed up
      Given I don't have registered account
       When I sign in with valid credentials
       Then I should see an invalid sign in message
        And I should be signed out

    Scenario: User enters wrong password
      Given I have registered account
       When I sign in with a wrong password
       Then I should see an invalid sign in message
        And I should be signed out