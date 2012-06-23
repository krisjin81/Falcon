Feature: Reset password
  In order to get access to me account
  As a user
  I want to be able to reset my password

  Background:
    Given I have registered account
      And I am not logged in

    Scenario: User receives reset password instruction
      When Ask to send me reset password instruction
      Then I should receive an email
      When I open the email
      Then I should see reset password link in email body

    Scenario: User resets his password using link from email
      When Ask to send me reset password instruction
      Then I should receive an email
      When I open the email
       And I click the first link in the email
      Then I should see change password page
      When I set new password
      Then I should see password changed message

    Scenario: User uses incorrect token to reset password
      When I use random token to reset password
      Then I should see change password page
      When I set new password
      Then I should see incorrect token message