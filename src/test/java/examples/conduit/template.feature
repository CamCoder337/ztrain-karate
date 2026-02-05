Feature: Home Work

    Background: Preconditions
        * url conduit_api

    Scenario: Favorite articles
        # Step 1: Get atricles of the global feed
        * def getArticles = call read('get-article.feature')
        * def articles = getArticles.response.articles

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
        * match response.response.article.favoritesCount == favoritesCount + 1

        # Step 6: Get all favorited articles on articles object
        * def username = login.response.user.username
        * def gatherFavArticles = call read('get-fav-article.feature') { username: "#(username)", token: "#(token)"}
        * def favoritedArticles = gatherFavArticles.response.articles

        # Step 7: Verify response schema
        * def articleScheme = read('response/article-scheme.json')
        * print "Favorited articles: ", favoritedArticles
        * match each favoritedArticles == articleScheme.article

        # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
        * match favoritedArticles[*].slug contains slug

    Scenario: Comment articles
        # Step 1: Get atricles of the global feed
        * def getArticles = call read('get-article.feature')
        * def articles = getArticles.response.articles

        # Step 2: Get the slug ID for the first arice, save it to variable
        * def firstArticle = articles[0]
        * def slug = firstArticle.slug

        # Step 3: Make a GET call to 'comments' end-point to get all comments
        * def login = call read('login.feature')
        * def token = login.response.user.token
        * def getComments = call read('get-comment.feature') { slug: "#(slug)", token: "#(token)" }
        * def comments = getComments.response.comments

        # Step 4: Verify response schema
        * def commentScheme = read('response/comment-scheme.json')
        * match each comments == commentScheme.comment

        # Step 5: Get the count of the comments array lentgh and save to variable
        * def baseCommentsCount = comments.length
        * print "Base Comments count: ", baseCommentsCount

        # Step 6: Make a POST request to publish a new comment
        * def commentBody = "New comment from  SHINSEKAI NARUTO" + login.response.user.username
        * def createComment = call read('create-comment.feature') { slug: "#(slug)", token: "#(token)", commentBody: "#(commentBody)" }
        * def createdCommentResponse = createComment.response
        * print "Response COMMENT HERER: ", createdCommentResponse
        # Step 7: Verify response schema that should contain posted comment text
        * def commentScheme = read('response/comment-scheme.json')
        * match createdCommentResponse.comment == commentScheme.comment
        * def comments = getComments.response

        # Step 8: Get the list of all comments for this article one more time
        * def getComments = call read('get-comment.feature') { slug: "#(slug)", token: "#(token)" }
        * def comments = getComments.response.comments

        # Step 9: Verify number of comments increased by 1 (similar like we did with favorite counts)
        * def commentsCount = comments.length
        * print "INC Comments count: ", commentsCount
        * match commentsCount == baseCommentsCount + 1

        # Step 10: Delete the comment we just created
        * def deleteComment = call read('delete-comment.feature') { slug: "#(slug)", token: "#(token)", commentId: "#(createdCommentResponse.comment.id)" }
        * def deleteCommentResponse = deleteComment.response

        * print "Response DELETE COMMENT HERER: ", deleteCommentResponse
        # Step 11: Get the list of all comments for this article one more time
        * def getComments = call read('get-comment.feature') { slug: "#(slug)", token: "#(token)" }
        * def comments = getComments.response.comments
        * def commentsCount = comments.length
        * print "DEC Comments count: ", commentsCount
        * match commentsCount == baseCommentsCount