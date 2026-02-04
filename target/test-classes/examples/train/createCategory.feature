    @CREATE_CATEGORY
Feature: Create a new category

  Background:
    * url 'https://api-ztrain.onrender.com'
    * def req = read('request/category.json')
    # Creer un nom unique avec timestamp
    * def uniqueId = java.lang.System.currentTimeMillis()
    * def originalName = req.name
    * set req.name = originalName + uniqueId

  Scenario: Create a new category

    # Etape 1: Login pour obtenir le token
    Given def loginResult = call read('trainLogin.feature')
    And print 'Token obtenu:', loginResult.response.token

    # Etape 2: Creer la categorie
    Given path '/category/create'
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer ' + loginResult.response.token
    And request req
    When method POST
    Then status 201
    And print 'Categorie creee:', response
