    @ignore
Feature: Creer un commentaire 
    Background: Preconditions
        * url conduit_api 

    Scenario: Creer un commentaire 
        Given path '/articles/' + slug + '/comments'
        * header Authorization = 'Token ' + token
        * request { "comment" : { "body" : "#(commentBody)" } }
        When method POST
        Then status 200
        And print "On a recuperer des commentaires"