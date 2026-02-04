    @ADD_COMMENT
Feature: Add a comment to a product

  Background:
    * url 'https://api-ztrain.onrender.com'
    * def req = read('request/comment.json')

  Scenario: Add a comment to a product

    # Etape 1: Login pour obtenir le token et user ID
    Given def loginResult = call read('trainLogin.feature')
    And print 'User ID:', loginResult.response.user._id
    And print 'Token:', loginResult.response.token

    # Etape 2: Creer un produit pour lui ajouter un commentaire
    Given def productResult = call read('createProduct.feature')
    And print 'Product ID:', productResult.response.id
    
    # Etape 3: Preparer la requete
    And set req.user_id = loginResult.response.user._id
    And set req.product = productResult.response.id
    And print 'Requete complete:', req

    # Etape 4: Ajouter le commentaire au produit
    Given path '/product/comments/add'
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer ' + loginResult.response.token
    And request req
    When method POST
    Then status 201
    And print 'Commentaire ajoute:', response
