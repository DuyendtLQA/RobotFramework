*** Settings ***
Resource    ../keywords/imports.robot

*** Test Cases ***
ALL_09,ALL_11
  [Documentation]                   Add product into cart
  [Tags]                            Check info when add product into cart
  Given Open Website
  When Add products into cart
  Then Get info products in cart
  And Check info products in cart
  And Compare total price all products in cart
  [Teardown]                        Close Website

ALL_10
  [Documentation]                   Add product into cart
  [Tags]                            Change info products in cart and check total price
  Given Open Website
  When Add products into cart
  Then Change quantity product in cart
  And Delete product in cart
  And Get info products in cart
  And Check info products in cart
  And Compare total price all products in cart
  [Teardown]                        Close Website


