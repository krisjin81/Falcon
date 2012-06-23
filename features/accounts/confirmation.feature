Feature: Confirmation
  In order to complete sign up process
  As a user
  I want to be able to confirm my email

    Background:
      Given I am not logged in

    Scenario: Unconfirmed account
      When I sign up with "j.smith@mail.com" and "password"
      Then Account should be created for "j.smith@mail.com"
       And I should receive an email with subject "Confirmation instructions"
      When I sign in with "j.smith@mail.com" and "password"
      Then I should see an unconfirmed account message

    Scenario: Confirmation
      When I sign up with "j.smith@mail.com" and "password"
      Then Account should be created for "j.smith@mail.com"
       And I should receive an email with subject "Confirmation instructions"
      When I open the email
       And I click the first link in the email
      Then I should see a successfully confirmed message
       And I should be signed in