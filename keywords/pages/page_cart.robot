*** Settings ***
Resource    ../common_keyword.robot
Resource    ../imports.robot
Library     ../../library/CartFc.py

*** Variables ***
${menu_link}         css=#main-nav  .main-nav__branding span
${link_food}         css=#main-nav a[href="/ha-noi/an-uong/"]
${product_item}      css=.row.products  > div:nth-of-type(

${quantity}          ${1}
${locator_name}      css=h1.product__title
${locator_price}     css=._product_price  span.price__value
${locator_price_value}      css=._product_price_old  .price__value
${locator_price_discount}   css=._product_price  .price__discount

${btn_add_to_cart}    css=#add-to-cart.btn--add-to-cart
${link_cart}          css=.header-cart-wrapper .btn--view-cart
${icon_cart}          css=.header-cart-wrapper i.hd.hd-cart

${product_cart}       css=tbody tr:nth-of-type(
${total_price_last}   css=#order-total

${quantity_select}=    css=tbody tr:nth-of-type(1) select
${quantity_option}=    css=tbody tr:nth-of-type(1) select option[value="3"]
${delete_product}=     css=tbody tr:nth-of-type(1) .action a

*** Keywords ***
Add products into cart
  ${products}=   Create List
  FOR  ${i}  IN RANGE  1   3
  Hover on element         ${menu_link}
  Wait And Click Element   ${link_food}
  ${product}=  Create Dictionary
  ${xpath_item} =   Catenate           SEPARATOR=     ${product_item}       ${i}     ) .product__image
  Wait And Click Element     ${xpath_item}
  Sleep  5s
  ${name}=    Get text       ${locator_name}
  ${price}=   Get text       ${locator_price}
  ${str_price} =	 Replace String   	${price}   	,     ${EMPTY}
  ${price}=   Convert To Integer    ${str_price}
  ${total}=   evaluate     ${price}*${quantity}

  Compare price after discount   ${price}

  Set To Dictionary 	${product} 	 name=${name}	  price=${price}   quantity=${quantity}    total=${total}
  append to list     ${products}    ${product}
  Wait And Click Element    ${btn_add_to_cart}
  END
  Set Global Variable    ${products}

  Wait And Click Element    ${link_cart}

Get info product item in cart
  [Arguments]     ${i}    ${products_cart_temp}

  ${product}=  Create Dictionary
  ${locator_pr}=    Catenate      SEPARATOR=     ${product_cart}       ${i}     )

  ${locator_pr_name}=     Catenate        ${locator_pr}      .name
  ${locator_pr_price}=    Catenate        ${locator_pr}      .unit label
  ${locator_pr_total}=    Catenate        ${locator_pr}      .total
  ${locator_pr_quantity}=    Catenate        ${locator_pr}    .quantity select option:checked

  ${pr_name}=     Get text        ${locator_pr_name}
  @{words} =	Split String	  ${pr_name}   \nMã SP
  ${name}=   Get From List  	${words}  	0

  ${pr_price}=    Get text        ${locator_pr_price}
  ${str_price_1}=	 Replace String   	${pr_price}   	đ    ${EMPTY}
  ${str_price_2}=	 Replace String   	${str_price_1}   	,    ${EMPTY}
  ${price}=        Convert To Integer    ${str_price_2}

  ${pr_quantity}=     Get text        ${locator_pr_quantity}
  ${quantity}=       Convert To Integer    ${pr_quantity}

  ${pr_total}=    Get text        ${locator_pr_total}
  ${str_total_1}=	 Replace String   	${pr_total}   	đ    ${EMPTY}
  ${str_total_2}=	 Replace String   	${str_total_1}   	,    ${EMPTY}
  ${total}=        Convert To Integer    ${str_total_2}

  ${total_temp}=    Evaluate     ${quantity}*${price}
  Should be equal    ${total_temp}      ${total}

  Set To Dictionary 	${product} 	 name=${name}	  price=${price}   quantity=${quantity}   total=${total}
  Append to list     ${products_cart_temp}    ${product}

Get info products in cart
  ${products_cart}=   Create List
  FOR    ${i}    IN RANGE    1   5
  Run keyword If    ${i%2} != 0    Get info product item in cart   ${i}    ${products_cart}
  END
  Set Global Variable    ${products_cart}

Check info products in cart
  ${check}=   Compare Two Products   ${products}   ${products_cart}
  Should Be Equal As Strings    ${check}   True

Compare total price all products in cart
  ${total_price}=    Get Total Price Product In Cart     ${products_cart}

  ${total_price_compare}=    Get text      ${total_price_last}
  ${str_price_1}=	 Replace String   	${total_price_compare}   	đ    ${EMPTY}
  ${str_price_2}=	 Replace String   	${str_price_1}   	,    ${EMPTY}
  ${prices}=        Convert To Integer    ${str_price_2}
  log  ${prices}
  Should be equal     ${total_price}    ${prices}

Change quantity product in cart
  Wait And Click Element   ${quantity_select}
  Wait And Click Element   ${quantity_option}
  ${products_items}=   Create List
  Get info product item in cart    1    ${products_items}

  ${product_item}=   Get From List  	${products_items}  	0
  ${products}=   Update Info Products    ${products}    ${product_item}   update
  Set Global Variable    ${products}

Delete product in cart
  ${products_items}=   Create List
  Get info product item in cart    1    ${products_items}

  ${product_item}=   Get From List  	${products_items}  	0
  ${products}=   Update Info Products    ${products}    ${product_item}   delete
  Set Global Variable    ${products}

  Wait And Click Element    ${delete_product}
  log  ${products}

Compare price after discount
  [Arguments]     ${price}
  ${price_value}=    Get text             ${locator_price_value}
  ${price_value}=    Replace String   	${price_value}   	,     ${EMPTY}
  ${price_value}=    Replace String   	${price_value}   	  đ     ${EMPTY}
  ${price_value}=    Convert To Integer   ${price_value}

  ${discount}=       Get text    ${locator_price_discount}
  ${discount}=    Replace String   	${discount}   	%     ${EMPTY}
  ${discount}=    Replace String   	${discount}   	 -    ${EMPTY}
  ${discount}=    Convert To Integer   ${discount}

  ${price_compare}=   Evaluate    ${price_value}*(100-${discount})/100
  ${price_compare}=   Convert To Number 	${price_compare} 	-3
  ${check}=    Evaluate    ${price_compare}-${price}
  Run Keyword Unless    ${check} < ${5000}     Fail
