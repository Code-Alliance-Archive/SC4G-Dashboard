Feature: Request Volunteers API
#TODO: refactor duplicating given step
#TODO: refactor

  Scenario: Index action (No filtering)
    Given the following volunteers exist:
      | id | email                  | name        |
      | 1  | TimOmbusa@example.com  | Tim Ombusa  |
      | 2  | MaksDiabin@example.com | Maks Diabin |
      | 3  | BG@MS.Com              | Bil Gs      |

    When I visit "/volunteers.json"
    Then the JSON response should have 3 users
    And the JSON response at row 0:name should be Tim Ombusa
    And the JSON response at row 1:name should be Maks Diabin
    And the JSON response at row 2:name should be Bil Gs

  Scenario: Index action (Filtering by name)
    Given the following volunteers exist:
      | id | email                  | name        |
      | 1  | TimOmbusa@example.com  | Tim Ombusa  |
      | 2  | MaksDiabin@example.com | Maks Diabin |
      | 3  | BG@MS.Com              | Bil Gs      |
    When I visit "volunteers.json?name=Tim"
    Then the JSON response should have 1 user
    And the JSON response at row 0:name should be Tim Ombusa

  Scenario: Index action (Filtering by email)
    Given the following volunteers exist:
      | id | email                  | name        |
      | 1  | TimOmbusa@example.com  | Tim Ombusa  |
      | 2  | MaksDiabin@example.com | Maks Diabin |
      | 3  | BG@MS.Com              | Bil Gs      |
    When I visit "volunteers.json?email=BG@ms.com"
    Then the JSON response should have 1 user
    And the JSON response at row 0:name should be Bil Gs

  Scenario: Index action (Filtering by company name)
    Given the following volunteers exist:
      | id | email                  | name        |
      | 1  | TimOmbusa@example.com  | Tim Ombusa  |
      | 2  | MaksDiabin@example.com | Maks Diabin |
      | 3  | BG@MS.Com              | Bil Gs      |
    And the volunteer with id:1 works at MelkoS
    When I visit "volunteers.json?company=MelkoS"
    Then the JSON response should have 1 user
    And the JSON response at row 0:name should be Tim Ombusa

  Scenario: Index action (Filtering by skills)
    Given the following volunteers exist:
      | id | email                  | name        |
      | 1  | TimOmbusa@example.com  | Tim Ombusa  |
      | 2  | MaksDiabin@example.com | Maks Diabin |
      | 3  | BG@MS.Com              | Bil Gs      |
    And the volunteer with id:2 has Product_Management skill
    When I visit "volunteers.json?skills[]=Product_Management"
    Then the JSON response should have 1 user
    And the JSON response at row 0:name should be Maks Diabin

  Scenario: Index action (Filtering by skills - negative)
    Given the following volunteers exist:
      | id | email                  | name        |
      | 1  | TimOmbusa@example.com  | Tim Ombusa  |
      | 2  | MaksDiabin@example.com | Maks Diabin |
      | 3  | BG@MS.Com              | Bil Gs      |
    And the volunteer with id:1 has Software_Development skill
    And the volunteer with id:2 has Product_Management skill
    And the volunteer with id:3 has Product_Management skill
    When I visit "volunteers.json?skills[]=Software_Development"
    Then the JSON response should have 1 user
    And the JSON response at row 0:name should be Tim Ombusa

