Feature: Sign up
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign up

    Background:
      Given I am not logged in

    Scenario Outline: User signs up with valid credentials
      When I sign up with "<email>" and "<password>"
      Then I should see a "<message>"
       And Account should be created for "<email>"

      Scenarios: valid credentials
        | email                 | password  | message                         |
        | j.smith@mail.com      | password  | confirmation link has been sent |
        | j_smith@mail.com      | qwerty    | confirmation link has been sent |
        | valid_email@mail.com  | 123qwe    | confirmation link has been sent |

    Scenario Outline: User signs up with invalid credentials
      When I sign up with "<email>" and "<password>"
      Then I should see a "<message>"

      Scenarios: invalid credentials
        | email                 | password  | message       |
        | invalid_email         | password  | is invalid    |
        | invalid_email.com     | password  | is invalid    |
        | invalid_email@com     | password  | is invalid    |
        | valid_email@mail.com  | qqq       | is too short  |
        | valid_email@mail.com  | qqqq      | is too short  |
        | valid_email@mail.com  | qqqqq     | is too short  |
        | valid_email@mail.com  | qqqqq     | is too short  |