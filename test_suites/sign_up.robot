*** Settings ***
Resource  ../keywords/imports.robot

*** Variables ***
${link_signup}          css=.hd-user ~ a
${btn_submit_signup}    xpath=//button[@type="submit"][contains(text(), "ĐĂNG KÝ")]

${email_temp1}       abc@123
${email_temp2}       df34hi@gmail.com
${password_temp}    abc@123
${day}      11
${month}    8
${year}     1999
${gender}   F

${text_signup_success}      Đăng ký tài khoản thành công
*** Test Cases ***
ALL_01
    [Documentation]  Create account 
    [Tags]              Create account with field email is invalid
    Given Open Website
    When Click link signup     ${link_signup}
    Then Input email signup            ${email_temp1} 
    And Element should be disabled      ${btn_submit_signup}
    [Teardown]  Close Website

ALL_02
    [Documentation]  Create account 
    [Tags]              Create account with all field valid
    Given Open Website
    When Click link signup            ${link_signup}
    Then Input email signup           ${email_temp2}   
    And Input password signup         ${password_temp} 
    And Input password2               ${password_temp}
    And Input birthday                ${day}  ${month}  ${year}
    And Check gender                  ${gender}
    And Click button sign up          ${btn_submit_signup}
    And Page should contain        ${text_signup_success}               
    [Teardown]  Close Website