    @ignore
Feature: Increment favorites count
    Background:
        * url 'https://conduit-api.bondaracademy.com/api'
    Scenario:
        Given path '/articles/', slug, '/favorite'
        When method POST
        Then status 200
