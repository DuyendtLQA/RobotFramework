*** Settings ***
Resource    ../keywords/imports.robot

*** Variables ***
${input_search}    xpath=//*[@id="search_all"]

*** Test Cases ***
ALL_03
  [Documentation]                    Search
  [Tags]                             Check auto hidden placeholder when enter text into input search
  Given Open Website
  When Capture Element Screenshot    ${input_search}                                        ../resources/images/image1.png
  Then Compare image when input text search
  And Compare image when delete text search
  [Teardown]    Close Website

ALL_04
  [Documentation]              Search
  [Tags]                       Check auto suggest when enter text into input search
  Given Open Website
  Check auto suggest when search
  [Teardown]    Close Website

ALL_05
  [Documentation]              Search
  [Tags]                       Check result exact when search
  Given Open Website
  Check result exact when search
  [Teardown]    Close Website

ALL_06
  [Documentation]              Search
  [Tags]                       Check result search and result suggest exact when search
  Given Open Website
  Check result search and result suggest exact when search
  [Teardown]    Close Website

ALL_07
  [Documentation]              Search
  [Tags]                       Check result search when search text not exits
  Given Open Website
  Check result search when search text not exits
  [Teardown]    Close Website

All_d
  [Documentation]              Search
  [Tags]                       Check result search when search text not exits
  ${list} =	 Create List
  FOR  ${i}  IN RANGE   1    5
  ${xpath_item} =   Catenate           SEPARATOR=     xpath=//xyz        ${i}     /abc
  append to list     ${list}    ${xpath_item}
  END
  log  ${list}
