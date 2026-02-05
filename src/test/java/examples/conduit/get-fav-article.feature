    @ignore
Feature: Recuperer les articles favoris
    Background: Preconditions
        * url conduit_api 

    Scenario: Recuperer les articles favoris
        Given path '/articles'
        And params { favorited: "#(username)"}
        * header Authorization = 'Token ' + token
        When method GET
        Then status 200
        And print "On a recuperer des articles favoris"