Feature: Recuperer les articles
    Background: Preconditions
        * url 'https://conduit-api.bondaracademy.com/api' 

    Scenario: Recuperer les articles
        Given path '/articles'
        When method GET
        Then status 200
        And print "On a recuperer des articles"