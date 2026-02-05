    @noToken
Feature: Public Articles Access

    Background:
        * url conduit_api

    Scenario: Retrieve global feed articles
        Given path 'articles'
        When method GET
        Then status 200
        And match response.articles == '#[]'
        And match response.articlesCount == '#number'
