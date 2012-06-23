@accounts
Feature: Change free account member password
  In order to protect my personal data
  As free account member
  I want to be able to change password

  Background:
    Given I am registered as free member account
      And I am logged in

    Scenario: Free account member changes his password
      When I visit change password page
       And I change my password
      Then I should see account updated message
      When I sign out
       And I sign in with new password
      Then I should see a successful sign in message
       And I should be signed in

    Scenario: Free account member changes his password without providing current password
      When I visit change password page
       And I change password without providing current password
      Then I should see required current password message

    Scenario: Free account member changes his email and password with providing incorrect current password
      When I visit change password page
       And I change password with and provide incorrect current password
      Then I should see incorrect current password message