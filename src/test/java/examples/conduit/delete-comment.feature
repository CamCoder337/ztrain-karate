    @ignore
Feature: Supprimer un commentaire 
    Background: Preconditions
        * url conduit_api 

    Scenario: Supprimer un commentaire 
        Given path '/articles/' + slug + '/comments/' + commentId
        * header Authorization = 'Token ' + token
        When method DELETE
        Then status 200 
        And print "On a supprimé le commentaire"