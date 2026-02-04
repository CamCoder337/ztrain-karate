Feature: Extract Data helper

    Scenario:
        * def firstArticle = articles.response.articles[0]
        * def slug = firstArticle.slug
        * def favoritesCount = firstArticle.favoritesCount
