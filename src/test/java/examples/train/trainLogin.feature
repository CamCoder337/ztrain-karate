    @LOGIN_TRAIN
Feature: Login User for Token

  Background:
    * url 'https://api-ztrain.onrender.com'

  Scenario: Login and get token
    Given path '/auth/login/'
    And request read('request/login.json')
    When method POST
    Then status 201
