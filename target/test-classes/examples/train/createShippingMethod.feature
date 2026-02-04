    @CREATE_SHIPPING
Feature: Create a shipping method

  Background:
    * url 'https://api-ztrain.onrender.com'
    * def req = read('request/shippingMethod.json')
    # Creer un nom unique avec timestamp
    * def uniqueId = java.lang.System.currentTimeMillis()
    * def originalName = req.designation
    * set req.designation = originalName + uniqueId

  Scenario: Create a new shipping method

    # Etape 1: Login pour obtenir le token
    Given def loginResult = call read('trainLogin.feature')
    And print 'Token obtenu:', loginResult.response.token

    # Etape 2: Creer la methode d'expedition
    Given path '/shipping-method/create'
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer ' + loginResult.response.token
    And request req
    When method POST
    Then status 201
    And print 'Methode d expedition creee:', response
