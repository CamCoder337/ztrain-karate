    @ZTRAIN
Feature: Create a product

  Background:
    * url 'https://api-ztrain.onrender.com/'

  Scenario: Create a product

    Given path '/auth/login/'
    And request read('request/login.json')
    When method POST
    Then status 201