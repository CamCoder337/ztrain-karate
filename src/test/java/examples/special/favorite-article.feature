    @needsToken
Feature: Authenticated Article Favoriting

    Background:
        * url conduit_api
        * def authFeature = call read('generate-token.feature')
        * def token = authFeature.token

    Scenario: Favorite the first available article
        # Get articles to find a slug
        Given path 'articles'
        When method GET
        Then status 200
        * def slug = response.articles[0].slug

        # Favorite the article
        Given path 'articles', slug, 'favorite'
        And header Authorization = 'Token ' + token
        When method POST
        Then status 200
        And match response.article.favorited == true
