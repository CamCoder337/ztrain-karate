Feature:LOGIN TO THE WEBSITEw
Background:
    * url 'https://conduit-api.bondaracademy.com/api/'

Scenario: Login with valid credentials
    Given path 'users/login'
    And request read('request/login.json')
    When method POST
    Then status 200
    * print response    

