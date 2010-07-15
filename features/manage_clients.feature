Feature: Manage clients
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new client
    Given I am on the new client page
    When I fill in "Name" with "name 1"
    And I fill in "Bill rate" with "1.0"
    And I fill in "Status" with "status 1"
    And I press "Create"
    Then I should see "name 1"
    And I should see "1.0"
    And I should see "status 1"

  # Rails generates Delete links that use Javascript to pop up a confirmation
  # dialog and then do a HTTP POST request (emulated DELETE request).
  #
  # Capybara must use Culerity/Celerity or Selenium2 (webdriver) when pages rely
  # on Javascript events. Only Culerity/Celerity supports clicking on confirmation
  # dialogs.
  #
  # Since Culerity/Celerity and Selenium2 has some overhead, Cucumber-Rails will
  # detect the presence of Javascript behind Delete links and issue a DELETE request 
  # instead of a GET request.
  #
  # You can turn this emulation off by tagging your scenario with @no-js-emulation.
  # Turning on browser testing with @selenium, @culerity, @celerity or @javascript
  # will also turn off the emulation. (See the Capybara documentation for 
  # details about those tags). If any of the browser tags are present, Cucumber-Rails
  # will also turn off transactions and clean the database with DatabaseCleaner 
  # after the scenario has finished. This is to prevent data from leaking into 
  # the next scenario.
  #
  # Another way to avoid Cucumber-Rails' javascript emulation without using any
  # of the tags above is to modify your views to use <button> instead. You can
  # see how in http://github.com/jnicklas/capybara/issues#issue/12
  #
  Scenario: Delete client
    Given the following clients:
      |name|bill_rate|status|
      |name 1|1.0|status 1|
      |name 2|2.0|status 2|
      |name 3|3.0|status 3|
      |name 4|4.0|status 4|
    When I delete the 3rd client
    Then I should see the following clients:
      |Name|Bill rate|Status|
      |name 1|1.0|status 1|
      |name 2|2.0|status 2|
      |name 4|4.0|status 4|
