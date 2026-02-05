    @ignore
Feature: Delete Comment Helper

    Background:
        * url conduit_api

    Scenario: Delete comment
        Given path 'articles', slug, 'comments', commentId
        And header Authorization = 'Token ' + token
        When method DELETE
        Then status 200
