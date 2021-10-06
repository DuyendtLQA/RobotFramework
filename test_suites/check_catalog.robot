*** Settings ***
Resource    ../keywords/imports.robot

*** Variables ***

*** Test Cases ***
ALL_12
  [Documentation]                   Check catalog
  [Tags]                            Check info when filter place in catalog
  Given Open Website
  Then Check info when filter place in catalog
  [Teardown]                        Close Website

ALL_13
  [Documentation]              Check catalog
  [Tags]                       Check sort place in catalog
  Given Open Website
  Then Check info when sort place in catalog
  [Teardown]                   Close Website

ALL_14
  [Documentation]              Follow us
  [Tags]                       Follow us on twiter
  Given Open Website
  Then Follow us on twiter
  [Teardown]                   Close Website