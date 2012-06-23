@affiliates
Feature: Reset password
  In order to get access to my account
  As an affiliate
  I want to be able to reset my password

  Background:
    Given I am registered as affiliate
      And I am not logged in as affiliate

    Scenario: Affiliate receives reset password instruction
      When I ask to send me reset password instruction as affiliate
      Then I should receive an email
      When I open the email
      Then I should see reset affiliate password link in email body

    Scenario: Affiliate resets his password using link from email
      When I ask to send me reset password instruction as affiliate
      Then I should receive an email
      When I open the email
       And I click the first link in the email
      Then I should see change password page
      When I set new affiliate password
      Then I should see password changed message

    Scenario: Affiliate uses incorrect token to reset affiliate password
      When I use random token to reset affiliate password
      Then I should see change password page
      When I set new affiliate password
      Then I should see incorrect token message