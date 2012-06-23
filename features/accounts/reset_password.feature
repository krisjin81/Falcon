@accounts
Feature: Reset password
  In order to get access to my account
  As free account member
  I want to be able to reset my password

  Background:
    Given I am registered as free member account
      And I am not logged in

    Scenario: Free account member receives reset password instruction
      When I ask to send me reset password instruction
      Then I should receive an email
      When I open the email
      Then I should see reset password link in email body

    Scenario: Free account member resets his password using link from email
      When I ask to send me reset password instruction
      Then I should receive an email
      When I open the email
       And I click the first link in the email
      Then I should see change password page
      When I set new password
      Then I should see password changed message

    Scenario: Free account member uses incorrect token to reset password
      When I use random token to reset password
      Then I should see change password page
      When I set new password
      Then I should see incorrect token message