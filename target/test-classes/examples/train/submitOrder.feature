    @SUBMIT_ORDER
Feature: Submit the order

  Background:
    * url 'https://api-ztrain.onrender.com'
    * def reqCart = read('request/addToCart.json')
    * def reqOrder = read('request/order.json')

  Scenario: Create product, add to cart, and submit order

    # Etape 1: Login pour obtenir le token et user ID
    Given def loginResult = call read('trainLogin.feature')
    And print 'User ID:', loginResult.response.user._id
    And print 'Token:', loginResult.response.token

    # Etape 2: Creer un produit
    Given def productResult = call read('createProduct.feature')
    And print 'Product ID:', productResult.response.id
    And def produitComplet = productResult.response

    # Etape 3: Ajouter le produit au panier
    Given path '/cart/add'
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer ' + loginResult.response.token
    And set reqCart.product = productResult.response.id
    And set reqCart.user_id = loginResult.response.user._id
    And request reqCart
    When method POST
    Then status 201
    And print 'Produit ajoute au panier'

    # Etape 4: Mettre a jour la quantite a 3
    Given path '/cart/update'
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer ' + loginResult.response.token
    And set reqCart.quantity = 3
    And request reqCart
    When method PUT
    Then status 200
    And print 'Quantite mise a jour'

    # Etape 5: Passer la commande
    Given path '/command/create'
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer ' + loginResult.response.token
    And set reqOrder.user_id = loginResult.response.user._id
    And set reqOrder.products[0].product = produitComplet
    And set reqOrder.products[0].quantity = 3
    And request reqOrder
    When method POST
    Then status 201
    And print 'Commande passee:', response
    # Verification du message de succes
    And match response.message contains 'Bravo'
