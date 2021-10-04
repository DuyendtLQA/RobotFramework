*** Settings ***
Resource    ../keywords/imports.robot
Library     ../../library/CommonFc.py

*** Variables ***
${input_search}    xpath=//*[@id="search_all"]
${image_1}         ./resources/images/image1.png
${image_2}         ./resources/images/image2.png
${image_3}         ./resources/images/image3.png

${path_1}          ../resources/images/image2.png
${path_2}          ../resources/images/image3.png

${text_search}     Bữa Ăn
${locator_suggest}         xpath=//a[contains(text(), 'Bữa Ăn')]
${text_suggest}            xpath=//a[contains(text(), '3 Bữa Ăn')]
${content_suggest}         xpath=//a[contains(text(),'3 Bữa...')]
${icon_search}             css=#main-search .hd.hd-search

${text_suggest_temp}       Romana Resort 4* Phan Thiết 2N1Đ - Phòng Deluxe Ocean View - Combo 3 Bữa Ăn - Ăn Sáng + Bữa Trưa Chọn Món Theo Menu + Bữa Tối Lẩu Thả/ Set Menu + Tặng 40P Xông Hơi + 20P Massage Hoặc Tặng 02h Karaoke + Giảm 20% Thực Đơn Ala Carte Dành Cho 02 Khách
${text_not_found}          Không tìm thấy sản phẩm phù hợp yêu cầu.
***Keywords***
Compare image when input text search
  ${text_search}=                   Generate Random String    10
  Wait and input text          ${input_search}           ${text_search}
  Capture Element Screenshot    ${input_search}           ${path_1}
  ${check}=                         Compare Images            ${image_1}                        ${image_2}
  Should Be Equal As Integers       ${check}	1

Compare image when delete text search
  Wait and input text           ${input_search}    ${EMPTY}
  Press Keys                        None               CTRL+a
  Press Keys                        None               CTRL+x
  Press Keys                        None               RETURN
  Capture Element Screenshot    ${input_search}    ${path_2}
  ${check}=                         Compare Images     ${image_2}                        ${image_3}
  Should Be Equal As Integers       ${check}	1
  ${check}=                         Compare Images     ${image_1}                        ${image_3}
  Should Be Equal As Integers       ${check}	0

Check auto suggest when search
  Wait and input text     ${input_search}                                        ${text_search}
  Wait for an element to appear     ${locator_suggest}
  Wait for an element to appear     ${text_suggest}

Check result exact when search
  Wait and input text     ${input_search}                                        ${text_search}
  Wait And Click Element          ${icon_search}
  Wait for an element to appear     ${content_suggest}

Check result search and result suggest exact when search
  Wait and input text     ${input_search}                                        ${text_search}
  # compare result
  Wait And Click Element          ${icon_search}
  Wait for an element to appear     ${content_suggest}
  ${text_temp1}=    Get Element Attribute     //a[contains(text(),'3 Bữa...')]    title
  ${text_temp2}=    Remove Spaces String  ${text_temp1}
  Should be equal as strings      ${text_temp2}      ${text_suggest_temp}

Check result search when search text not exits
  Wait and input text             ${input_search}               xxx
  Wait And Click Element          ${icon_search}
  Wait for an text to appear      ${text_not_found}