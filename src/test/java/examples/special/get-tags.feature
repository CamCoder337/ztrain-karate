    @noToken
Feature: Public Tags Access

    Background:
        * url conduit_api

    Scenario: Retrieve all popular tags
        Given path 'tags'
        When method GET
        Then status 200
        And match response.tags == '#[] #string'
