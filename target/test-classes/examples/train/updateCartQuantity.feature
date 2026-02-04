    @UPDATE_CART_QUANTITY
Feature: Update product quantity in cart

  Background:
    * url 'https://api-ztrain.onrender.com'
    * def req = read('request/addToCart.json')

  Scenario: Update quantity to 3 in cart

    # Etape 1: Login pour obtenir le token et user ID
    Given def loginResult = call read('trainLogin.feature')
    And print 'User ID:', loginResult.response.user._id
    And print 'Token:', loginResult.response.token

    # Etape 2: Creer un produit
    Given def productResult = call read('createProduct.feature')
    And print 'Product ID:', productResult.response.id

    # Etape 3: Ajouter le produit au panier d'abord
    Given path '/cart/add'
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer ' + loginResult.response.token
    And set req.product = productResult.response.id
    And set req.user_id = loginResult.response.user._id
    And request req
    When method POST
    Then status 201
    And print 'Produit ajoute au panier'

    # Etape 4: Mettre a jour la quantite a 3
    Given path '/cart/update'
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer ' + loginResult.response.token
    And set req.quantity = 3
    And request req
    When method PUT
    Then status 200
    And print 'Quantite mise a jour a 3:', response
