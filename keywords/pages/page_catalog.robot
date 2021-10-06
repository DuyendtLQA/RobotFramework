*** Settings ***
Resource    ../keywords/imports.robot
Library     ../../library/CommonFc.py

*** Variables ***
${link_food}    css=#main-nav a[href="/ha-noi/an-uong/"]

${place_one}          css=div:nth-child(2) > div.filter__body label
${number_products}    css=div:nth-child(2) > div.filter__body label span
${product_item}       css=.row.products > div

${locator_product_item}    css=.row.products                               > div:nth-of-type(
${product_item_one}        css=.row.products                               > div:nth-of-type(1)
${locator_place}           css=#category_content .filter__button.active

${btn_sort}                xpath=//a[contains(text(),"Giá tốt nhất ")]
${btn_follow_us}           css=.fa.fa-twitter
${btn_follow_hotdeal}      css=div[aria-label="Follow @HotdealVietnam"]

*** Keywords ***
Check info when filter place in catalog
  Wait And Click Element         ${link_food}
  Wait And Click Element         ${place_one}
  Sleep                          20s
  ${total_products}=             Get Text             ${number_products}
  ${count_product}=              Get Element Count    ${product_item}
  Should Be Equal As Integers    ${total_products}    ${count_product}

  ${place_text}=                Get Text               ${locator_place}
  Wait And Click Element        ${product_item_one}
  Wait for an text to appear    ${place_text}

Check info when sort place in catalog
  Wait And Click Element        ${link_food}
  Wait And Click Element        ${btn_sort}
  ${list_price}=                Create List
  ${count_product}=             Get Element Count     ${product_item}
  FOR                           ${i}                  IN RANGE           1                          ${count_product}+1
  ${item}=                      Catenate              SEPARATOR=         ${locator_product_item}    ${i}                  ) ._product_price .price__value
  ${item}=                      Get Text              ${item}
  ${item}=                      Replace string        ${item}            ,                          ${EMPTY}
  ${item}=                      Convert To Integer    ${item}
  Append To List                ${list_price}         ${item}
  END
  ${check}=                     Check List Desc       ${list_price}
  Should Be Equal As Strings    ${check}              True

Follow us on twiter
  # click button follow
  Scroll Element into View      ${btn_follow_us}
  Wait And Click Element        ${btn_follow_us}
  Sleep   10s
  ${handles}=   Get Window Handles
  Switch Window   ${handles}[1]
  Wait And Click Element        ${btn_follow_hotdeal}
