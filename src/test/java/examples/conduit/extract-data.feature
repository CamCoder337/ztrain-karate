    @ignore
Feature: Extract Data helper

    Scenario:
        * def articles = articles

        * def firstArticle = articles[0]
        * def slug = firstArticle.slug  
        * def favoritesCount = firstArticle.favoritesCount
