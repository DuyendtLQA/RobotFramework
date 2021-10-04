*** Settings ***
Resource    ../keywords/imports.robot

*** Variables ***
# data test
${email_temp1}      abc@123
${email_temp2}      @gmail.com
${password_temp}    abc@123
${day}              11
${month}            8
${year}             1999
${gender}           F

${text_signup_success}    Đăng ký tài khoản thành công
${btn_submit_signup}    xpath=//button[@type="submit"][contains(text(), "ĐĂNG KÝ")]

*** Test Cases ***
ALL_01
  [Documentation]                   Create account
  [Tags]                            Create account with field email is invalid
  Given Open Website
  When Click link signup
  Then Input email signup           ${email_temp1}
  And Element should be disabled    ${btn_submit_signup}
  And Check popup email errors
  [Teardown]                        Close Website


ALL_02
  [Documentation]              Create account
  [Tags]                       Create account with all field valid
  Given Open Website

  When Click link signup
  ${email_random}=       Generate Random String    10
  ${email_temp3}=        Catenate         SEPARATOR=    ${email_random}   ${email_temp2}
  Then Input email signup      ${email_temp3}
  And Input password signup    ${password_temp}
  And Input password2          ${password_temp}
  And Input birthday           ${day}   ${month}   ${year}
  And Check gender             ${gender}
  And Click button sign up
  And Page should contain      ${text_signup_success}

  [Teardown]                   Close Website