@affiliates
Feature: Change affiliate password
  In order to protect my personal data
  As an affiliate
  I want to be able to change password

  Background:
    Given I am registered as affiliate
      And I am logged in as affiliate

    Scenario: Affiliate changes his password
      When I visit change password page as affiliate
       And I change my affiliate password
      Then I should see account updated message
      When I sign out as affiliate
       And I sign in as affiliate with new password
      Then I should see a successful sign in message
       And I should be signed in

    Scenario: Affiliate changes his password without providing current password
      When I visit change password page as affiliate
       And I change my affiliate password without providing current password
      Then I should see required current password message

    Scenario: Affiliate changes his email and password with providing incorrect current password
      When I visit change password page as affiliate
       And I change my affiliate password and provide incorrect current password
      Then I should see incorrect current password message