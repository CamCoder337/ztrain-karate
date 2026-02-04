    @ADD_TO_FAVORITE
Feature: Add product to favorites

  Background:
    * url 'https://api-ztrain.onrender.com'
    * def req = read('request/favorite.json')

  Scenario: Add a product to favorites

    # Etape 1: Login pour obtenir le token et user ID
    Given def loginResult = call read('trainLogin.feature')
    And print 'User ID:', loginResult.response.user._id
    And print 'Token:', loginResult.response.token

    # Etape 2: Creer un produit pour l'ajouter aux favoris
    Given def productResult = call read('createProduct.feature')
    And print 'Product ID:', productResult.response.id

    # Etape 3: Ajouter le produit aux favoris
    Given path '/favorites/add'
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer ' + loginResult.response.token
    And set req.user = loginResult.response.user._id
    And set req.product = productResult.response.id
    And request req
    When method POST
    Then status 201
    And print 'Produit ajoute aux favoris:', response
