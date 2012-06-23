Feature: Edit account details
  In order to protect my personal data
  As a user
  I want to be able to change password

  Background:
    Given I have registered account
      And I am logged in

    Scenario: User change his password
      When I visit change password page
       And I change my password
      Then I should see account updated message
      When I sign out
       And I sign in with new password
      Then I should see a successful sign in message
       And I should be signed in

    Scenario: User change his password without providing current password
      When I visit change password page
       And I change password without providing current password
      Then I should see required current password message

    Scenario: User change his email and password with providing incorrect current password
      When I visit change password page
       And I change password with and provide incorrect current password
      Then I should see incorrect current password message