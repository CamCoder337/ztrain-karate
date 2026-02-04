    @CREATE_PRODUCT
Feature: Create a new product

  Background:
    * url 'https://api-ztrain.onrender.com'
    # Lecture du fichier JSON de requete
    * def req = read('request/createProduct.json')
    # Creation d'un nom unique avec timestamp
    * def uniqueId = java.lang.System.currentTimeMillis()
    * def originalName = req.name
    * set req.name = originalName + uniqueId

  Scenario: Create product with dynamic name

    # Etape 1: Login pour obtenir le token
    Given def loginResult = call read('trainLogin.feature')
    And print 'Token obtenu:', loginResult.response.token

    # Etape 2: Creer le produit
    Given path '/product/create'
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer ' + loginResult.response.token
    And request req
    When method POST
    Then status 201
    And print 'Produit cree:', response

    # Etape 3: Tests de verification
    # Verifier que le prix est bien 10
    And match response.price == 10
    # Verifier que les attributs contiennent "M"
    And match response.attributs.height contains 'M'
    # Verifier que isActive est false
    And match response.isActive == false
    # Verifier que le nom contient notre prefixe
    And match response.name contains 'Produit Test'
