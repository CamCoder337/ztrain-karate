    @ignore
Feature: Generate Token

    Background:
        * url conduit_api

    Scenario: Generate valid token
        Given path 'users/login'
        And request { "user": { "email": "yvannouafo29@gmail.com", "password": "Azerty1234567" } }
        When method POST
        Then status 200
        * def token = response.user.token
