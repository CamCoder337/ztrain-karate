    @ADD_TO_CART
Feature: Add product to cart

  Background:
    * url 'https://api-ztrain.onrender.com'
    * def req = read('request/addToCart.json')

  Scenario: Add a product to cart

    # Etape 1: Login pour obtenir le token et user ID
    Given def loginResult = call read('trainLogin.feature')
    And print 'User ID:', loginResult.response.user._id
    And print 'Token:', loginResult.response.token

    # Etape 2: Creer un produit pour l'ajouter au panier
    Given def productResult = call read('createProduct.feature')
    And print 'Product ID:', productResult.response.id

    # Etape 3: Ajouter le produit au panier
    Given path '/cart/add'
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer ' + loginResult.response.token
    # Remplir les champs dynamiquement
    And set req.product = productResult.response.id
    And set req.user_id = loginResult.response.user._id
    And request req
    When method POST
    Then status 201
    And print 'Produit ajoute au panier:', response
