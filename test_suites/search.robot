*** Settings ***
Resource    ../keywords/imports.robot
Library     ../library/CommonFc.py

*** Variables ***
${input_search}    xpath=//*[@id="search_all"]
${image_1}         ./resources/Images/image1.png
${image_2}         ./resources/Images/image2.png
${image_3}         ./resources/Images/image3.png

*** Test Cases ***
ALL_03
  [Documentation]                    Search
  [Tags]                             Check auto hidden when enter text into input search
  Given Open Website
  When Capture Element Screenshot    ${input_search}                                        ../resources/Images/image1.png
# compare when input text search
  ${text_search}=                   Generate Random String    10
  log                               ${text_search}
  Then Wait and input text          ${input_search}           ${text_search}
  And Capture Element Screenshot    ${input_search}           ../resources/Images/image2.png
  ${check}=                         Compare Images            ${image_1}                        ${image_2}
  Should Be Equal As Integers       ${check}	1

# compare when delete text search
  And Wait and input text           ${input_search}    ${EMPTY}
  Press Keys                        None               CTRL+a
  Press Keys                        None               CTRL+x
  Press Keys                        None               RETURN
  And Capture Element Screenshot    ${input_search}    ../resources/Images/image3.png
  ${check}=                         Compare Images     ${image_2}                        ${image_3}
  Should Be Equal As Integers       ${check}	1
  ${check}=                         Compare Images     ${image_1}                        ${image_3}
  Should Be Equal As Integers       ${check}	0

  [Teardown]    Close Website

ALL_04
  [Documentation]              Search
  [Tags]                       Check auto suggest when enter text into input search
  Given Open Website

  ${text_search}=              Generate Random String     10    [LOWER]
  Then Wait and input text     ${input_search}                                        ${text_search}
  ${locator_suggest}=          Catenate         SEPARATOR=     xpath=//a[contains(text(), '    ${text_search}    ')]
  And Wait for an element to appear     ${locator_suggest}

  [Teardown]    Close Website
