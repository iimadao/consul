@setupApplicationTest
Feature: dc / intentions / permissions / warn: Intention Permission Warn
  Scenario:
    Given 1 datacenter model with the value "datacenter"
    And 1 intention model from yaml
    ---
      SourceNS: default
      SourceName: web
      DestinationNS: default
      DestinationName: db
      Action: ~
      Permissions:
      - Action: allow
        HTTP:
          PathExact: /path
    ---
    When I visit the intention page for yaml
    ---
      dc: datacenter
      intention: intention-id
    ---
    Then the url should be /datacenter/intentions/intention-id
    And I click "[value='deny']"
    And I submit
    And the warning object is present
    And I click the warning.cancel object
    And the warning object isn't present
    And I submit
    And the warning object is present
    And I click the warning.confirm object
    Then a PUT request was made to "/v1/connect/intentions/exact?source=default%2Fweb&destination=default%2Fdb&dc=datacenter" from yaml
