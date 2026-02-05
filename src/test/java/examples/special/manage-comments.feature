    @needsToken
Feature: Authenticated Comment Management

    Background:
        * url conduit_api
        * def authFeature = call read('generate-token.feature')
        * def token = authFeature.token
        
        # Get a slug to work with
        * def getArticles = call read('get-articles.feature')
        * def slug = getArticles.response.articles[0].slug

        # Step 15: Add an after scenario to delete those comments
        # In Karate, we can use 'configure afterScenario'
        * configure afterScenario = 
        """
        function() {
          var commentId = karate.get('commentId');
          if (commentId) {
            karate.log('Cleaning up comment:', commentId);
            karate.call('delete-comment-helper.feature', { slug: slug, token: token, commentId: commentId });
          }
        }
        """

    # Step 14: To create comments, use examples with scenario outline
    Scenario Outline: Create multiple comments on an article
        Given path 'articles', slug, 'comments'
        And header Authorization = 'Token ' + token
        And request { "comment": { "body": "<commentBody>" } }
        When method POST
        Then status 200
        
        # Step 13: Add regex verifications for dates ("2024-01-27T21:32:21.056Z")
        # The pattern for ISO-8601 like dates
        * def dateRegex = '^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}Z$'
        And match response.comment.createdAt == '#regex ' + dateRegex
        And match response.comment.updatedAt == '#regex ' + dateRegex
        And match response.comment.body == '<commentBody>'
        
        # Set commentId for afterScenario cleanup
        * def commentId = response.comment.id

        Examples:
            | commentBody              |
            | First automated comment  |
            | Second automated comment |
