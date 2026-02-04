Feature: Home Work

    Background: Preconditions
        * url 'https://conduit-api.bondaracademy.com/api' 

    Scenario: Favorite articles
        # Step 1: Get atricles of the global feed
        * def articles = call read('get-article.feature')
        * def articles = articles.response.articles

        # Step 2: Get the favorites count and slug ID for the first arice, save it to variables
        * def firstArticle = articles[0]
        * def slug = firstArticle.slug  
        * def favoritesCount = firstArticle.favoritesCount

        # Step 3: Make POST request to increse favorites count for the first article
        * def login = call read('login.feature')
        * def token = login.response.user.token

        * def response = call read('favorite-inc.feature') { slug: "#(slug)", token: "#(token)" }

        # Step 4: Verify response schema
        * def articleScheme = read('response/article-scheme.json')
        * match response.response == articleScheme

        # Step 5: Verify that favorites article incremented by 1
            * def initialCount = favoritesCount
            * match response.response.article.favoritesCount == initialCount + 1

        # Step 6: Get all favorited articles on articles object
        * def favoritedArticles = articles.filter(article => article.favorited == true)

        # Step 7: Verify response schema
        * def articleScheme = read('response/article-scheme.json').article
        * match each favoritedArticles == articleScheme

        # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
        * def articleSlug = favoritedArticles[0].slug
        * match articleSlug == slug

    # Scenario: Comment articles
    #     # Step 1: Get atricles of the global feed
    #     # Step 2: Get the slug ID for the first arice, save it to variable
    #     # Step 3: Make a GET call to 'comments' end-point to get all comments
    #     # Step 4: Verify response schema
    #     # Step 5: Get the count of the comments array lentgh and save to variable
    #         #Example
    #         * def responseWithComments = [{"article": "first"}, {article: "second"}]
    #         * def articlesCount = responseWithComments.length
    #     # Step 6: Make a POST request to publish a new comment
    #     # Step 7: Verify response schema that should contain posted comment text
    #     # Step 8: Get the list of all comments for this article one more time
    #     # Step 9: Verify number of comments increased by 1 (similar like we did with favorite counts)
    #     # Step 10: Make a DELETE request to delete comment
    #     # Step 11: Get all comments again and verify number of comments decreased by 1