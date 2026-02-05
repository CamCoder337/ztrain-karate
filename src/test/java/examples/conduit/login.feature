@ignore
Feature:LOGIN TO THE WEBSITEw
Background:
    * url conduit_api

Scenario: Login with valid credentials
    Given path 'users/login'
    And request read('request/login.json')
    When method POST
    Then status 200
    * print response    

