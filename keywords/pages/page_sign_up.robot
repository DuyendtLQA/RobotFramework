*** Settings ***
Resource    ../common_keyword.robot
Resource    ../imports.robot

*** Variables ***
${link_signup}          css=.hd-user ~ a
${btn_submit_signup}    xpath=//button[@type="submit"][contains(text(), "ĐĂNG KÝ")]

${input_email_signup}        css=#main [name="email"]
${input_password_signup}     css=#main #password
${input_password2_signup}    css=#main #password2
${icon_birthday_signup}      css=#main                   [class="hd hd-calendar"]

${icon_check_err}                 xpath=//i[@data-fv-icon-for='email']
${text_email_err}                 Email không hợp lệ
${popup_email_err}                css=.popover-content

# select year, month
${select_year}     css=.calendar.left .yearselect
${select_month}    css=.calendar.left .monthselect

${month_t}     .calendar.left .monthselect option[value="
${day_t}       xpath=//*[@class="calendar left single"]//table//td[contains(text(),
${gender_t}    xpath=//input[@name="gender" and @value="
*** Keywords ***
Click link signup
  Wait And Click Element    ${link_signup}

Check popup email errors
  Hover on element                  ${icon_check_err}
  ${text_err}=      Get text        ${popup_email_err}
  Should Be Equal                   ${text_err}         ${text_email_err}

Input email signup
  [Arguments]            ${email}
  Wait and input text    ${input_email_signup}    ${email}

Input password signup
  [Arguments]            ${password}
  Wait and input text    ${input_password_signup}    ${password}

Input password2
  [Arguments]            ${password2}
  Wait and input text    ${input_password2_signup}    ${password2}

Input birthday
  [Arguments]               ${day}                     ${month}    ${year}
  # click icon birthday
  Wait And Click Element    ${icon_birthday_signup}

  # click select year
  Wait And Click Element    ${select_year}
  Press Keys                None              ${year}

  # click select month
  Wait And Click Element    ${select_month}    
  ${month_option}=          Catenate           SEPARATOR=    css=    ${month_t}    ${month}    "]
  Wait And Click Element    ${month_option}

  # click day
  ${day_option}=            Catenate         SEPARATOR=    ${day_t}    ${day}    )]
  Wait And Click Element    ${day_option}

Check gender
  [Arguments]               ${gender}
  ${gender_option}=         Catenate            SEPARATOR=    ${gender_t}    ${gender}    "]
  Wait And Click Element    ${gender_option}

Click button sign up
  Wait And Click Element    ${btn_submit_signup}

