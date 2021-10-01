*** Settings ***
Documentation  This is some basic info about the whole suite
Library             SeleniumLibrary
# Library              String
# Library             BuiltIn
# Library             Collections

*** Keywords ***
Open Website
    ${list} =                  Create List           --ignore-certificate-errors    --ignore-ssl-errors                     --disable-extensions
    ${args} =                  Create Dictionary     args=${list}
    ${desired caps} =          Create Dictionary     chromeOptions=${args}
    open browser               ${environment_url}    ${browser}                     desired_capabilities=${desired caps}
    maximize browser window
    click element       xpath=//button[contains(text(),"ĐỒNG Ý")]

Wait and input text
    [Arguments]                    ${locator}    ${txt_value}
    wait until keyword succeeds    1 minute      5 seconds       element should be enabled    ${locator}
    input text                     ${locator}    ${txt_value}

Wait And Click Element
     [Arguments]                    ${locator}
#    wait until keyword succeeds    1 minute      5 seconds    element should be visible    ${locator}
     wait until keyword succeeds    1 minute      5 seconds    element should be enabled    ${locator}
     click element                  ${locator}

Wait And Click Element By Text
    [Arguments]                 ${text}
    Wait Until Page Contains    ${text}                  40s
    click element               //*[text()='${text}']

Wait And Select Option By Index
    [Arguments]                    ${locator}    ${index}
    wait until keyword succeeds    1 minute      5 seconds    element should be visible    ${locator}    40s
    select from list by index      ${locator}    ${index}

Check Element Visible
    [Arguments]    ${locator}
    ${present}=    run keyword and return status    ELEMENT SHOULD BE VISIBLE    ${locator}    10s
    [Return]       ${locator}

Choose And Upload File
    [Arguments]                      ${locator}    ${path}
    wait until element is enabled    ${locator}
    choose file                      ${locator}    ${path}

Click Element By JavaScript
    [Arguments]                      ${locator}                                                                            ${wait_time}
    wait until element is visible    ${locator}                                                                            ${wait_time}
    ${locator}=                      replace string                                                                        ${locator}      xpath=    ${empty}
    ${locator}=                      replace string                                                                        ${locator}      css=      ${empty}
    execute javascript               document.evaluate("${locator}",document.body,null,9,null).singleNodeValue.click();

Execute JavaScript Click On Element By Xpath
    [Arguments]                         ${locator}                                                                                            ${wait_time}
    [Documentation]                     Execute JavaScript Click On Element By Xpath
    wait until page contains element    ${locator}                                                                                            ${wait_time}
    Execute JavaScript                  document.evaluate("${locator}", document, null, XPathResult.ANY_TYPE, null).iterateNext().click();

Select App Frame
    [Arguments]                         ${iframe}
    wait until page contains element    ${iframe}    90s
    wait until keyword succeeds         1 minute     5 seconds    element should be visible    ${iframe}
    sleep                               10s
    select frame                        ${iframe}

Hover on element
    [Arguments]                    ${locator}
    wait until keyword succeeds    1 minute      5seconds    page should contain element    ${locator}    
    Mouse Over                     ${locator}

Wait for an element to appear
    [Arguments]                     ${locator}
    wait until keyword succeeds    1 minute      5seconds    page should contain element    ${locator}    

Close Website
    close browser

Get x offset of element
    [Arguments]                    ${locator}
    wait until keyword succeeds    1 minute              5seconds                                                                                                                            page should contain element    ${locator}    
    ${result}=                     Execute Javascript    return document.evaluate("${locator}".replace("xpath=", ""),document.body,null,9,null).singleNodeValue.getBoundingClientRect().x
    [Return]                       ${result}

Drag And Drop Element
    [Arguments]    ${src}    ${tgt}

    Wait Until Keyword Succeeds    ${ATTEMPTS}    ${LARGER_TIMEOUT}    Mouse Down    ${src}
    Sleep                          1s
    Wait Until Keyword Succeeds    ${ATTEMPTS}    ${LARGER_TIMEOUT}    Mouse Out     ${src}
    Sleep                          1s
    Capture Page Screenshot
    Wait Until Keyword Succeeds    ${ATTEMPTS}    ${LARGER_TIMEOUT}    Mouse Over    ${tgt}
    Sleep                          1s
    Wait Until Keyword Succeeds    ${ATTEMPTS}    ${LARGER_TIMEOUT}    Mouse Up      ${tgt}
    Sleep                          1s

Concat xpath
    [Arguments]     ${xpath1}   ${SEPARATOR}   ${xpath2}
    ${xpath2}=                              replace string              ${xpath2}          xpath=          ${empty}
    ${result}=                              Catenate    SEPARATOR=${SEPARATOR}  ${xpath1}   ${xpath2}
    [Return]  ${result}
