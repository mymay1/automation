*** Settings ***
Documentation     A test suite for verifying Shopping bag page. A customer is able to add the product, adjust size and quantity and then proceed to checkout
Library           RequestsLibrary
Library           SeleniumLibrary
Library           String

*** Variables ***
${URL}    https://www.pomelofashion.com/th/en/ 
${BROWSER}   Chrome


#variables path
#Register path
${MENU_REGISTER}   //button[@data-cy='nav_sign_up']
${REGISTER_FORM}   //section[contains(@class,'auth__wrapper')]
${REGISTER_EMAIL_FORM}   //form[contains(@class,'auth__email-form')]
${REGISTER_EMAIL}   //input[@name='email']
${REGISTER_FIRSTNAME}   //input[@name='firstName']
${REGISTER_LASTNAME}   //input[@name='lastName']
${REGISTER_PASSWORD}   //input[@name='password']
${REGISTER_CREATE_ACCOUNT_BTN}   //button[@data-cy='auth__login__email__button']
${USER_ACCOUNT_NAME}   //span[contains(@class,'body2 welcome-msg')]
${WELCOME_DLG}   //button[contains(@class,'auth__close')]
#Login path
${MENU_LOGIN}    //li[@data-cy='auth__login__menu']//span[@class='body2']
${LOGIN_TITLE}    //span[@class='h4 auth__title']
${LOGIN_EMAIL}   //div[contains(@class,'tabs__container auth__tabs')]//span[contains(text(),'Email')]
${LOGIN_EMAIL_FORM}   //form[contains(@class,'auth__email-form')]
${USERNAME_TEXTBOX}   //form[contains(@class,'auth__email-form')]/div/div/div/input
${PASSWORD_TEXTBOX}   //form[contains(@class,'auth__email-form')]/div[2]/div/div/input
${LOGIN_BTN}   //form[contains(@class,'auth__email-form')]/button[@type='submit']
${LOGIN_USER_ICON}   //li[@data-cy='auth__user__menu']
${USER_TOOLTIP}   //div[@id='user-tooltip']
${LOGOUT_BTN}   //a[@data-cy='desktop_menu_item___logout']



#Product detail path
${MENU_SHOP}      //li[@class='menu-link']//div[@data-cy='nav_desktop__shop']
${PRODUCT_DETAIL}   //div[@class='pdp__information-container']
${PRODUCT_NAME}   //span[@class='pdp__name-self body2']
${PRODUCT_IMAGE}   //div[@class='product-item ']//picture
${ADD_TO_BAG_BTN}  //button[contains(@class,'pml-btn pml-btn-pri pdp__add-to-bag-cta')]
#Item added to Bag Dialog
${ITEM_ADDED_BAG_DLG}  //div[contains(@class,'cart-notice-container')]
${ITEM_ADDED_PRODUCT_NAME}   //div[contains(@class,'cart-notice__prod-name')]
${ITEM_ADDED_VIEW_SHOPPING_BAG_BTN}   //button[@data-cy='cart__view_bag']
${ITEM_ADDED_CLOSE_BTN}   //span[@data-cy='close_cart_notice']

#Cart
${MENU_CART}   //li[@data-cy='nav_user__cart']
${SHOPPING_BAG_DLG}   //div[contains(@class,'shopping-bag')]
${SHOPPING_BAG_TITLE}   //span[contains(@class,'subtitle1 shopping-bag__title')]
${SHOPPING_BAG_PRODUCT}   //div[contains(@class,'cart-body')]
#Promo
${SHOPPING_BAG_PROMO}   //input[@placeholder='Enter Promo Code']
${SHOPPING_BAG_PROMO_APPLY}   //button[contains(@class,'pml-btn')]/span[contains(text(),'Apply')]
${SHOPPING_BAG_PROCEED_BTN}   //button[@data-cy='cart__checkout']
${SHOPPING_BAG_CLOSE_BTN}   //span[@data-cy='close_cart']
#Checkout
${CHECKOUT_POMELO_LOGO}      //a[contains(@class,'pomelo-logo__wrapper')]
${CHECKOUT_SHIPPING}   //label[@for='CHECKOUT_STEPS_SHIPPING']/span
${CHECKOUT_PAYMENT}   //label[@for='CHECKOUT_STEPS_PAYMENT']/span
${CHECKOUT_CONFIRM}   //label[@for='CHECKOUT_STEPS_CONFIRM']/span 
#Search
${SEARCH_BTN}   //li[contains(@class,'header-section__ul-icon-search')]
${SEARCH_FORM}   //form[contains(@class,'search-form-container flex-form')]
${SEARCH_FIELD}   //input[contains(@class,'body2 pml-input__input')]


*** Test Cases ***
A customer is able to add and adjust the products any category and proceed to checkout
    [Documentation]   A customer is able to register to website then add and adjust the products and then proceed to checkout
    [Setup]   Open Login Page   ${URL}
    Register User Account With Email Address   automation@hotmail.com   Automatation   Testing   Aa24680!1
    Add A Product With Any Category    Floral Print Dress - Light Pink   L
    Navigate To Cart Page
    Verify A Product In Shopping Bag    Floral Print Dress - Light Pink     L    1
    Close Shopping Bag
    Add A Product With Any Category    Wanderlust Olivia Frost Pointed Toe Flats - Navy   39
    Navigate To Cart Page
    Verify A Product In Shopping Bag    Wanderlust Olivia Frost Pointed Toe Flats - Navy   39    1
    Adjust Size Of Procuct In Shopping Bag     Floral Print Dress - Light Pink    M
    Verify A Product In Shopping Bag   Floral Print Dress - Light Pink     M    1
    Adjust Quantity Of Procuct In Shopping Bag    Floral Print Dress - Light Pink   2
    Verify A Product In Shopping Bag   Floral Print Dress - Light Pink     M    2
    Delete A Procuct In Shopping Bag    Wanderlust Olivia Frost Pointed Toe Flats - Navy
    Enter Promo Code And Click Apply   promoCode
    Proceed To Checkout
    [Teardown]   Run Keywords   Logout Page   AND   Close Browser   
  
*** Keywords ***


Open Login Page
    [Documentation]   A customer is able to open a website
    [Arguments]    ${url}   
    Open Browser   ${url}    ${BROWSER}    
    Maximize Browser Window
    Wait Until Element Is Visible   ${MENU_LOGIN}    20
    

Register User Account With Email Address
    [Documentation]   A customer is able to register user account by using Email Address and then register success
    [Arguments]    ${email}   ${firstname}     ${lastname}     ${psw}
    Wait Until Element Is Visible   ${MENU_REGISTER}   20
    Click Element    ${MENU_REGISTER}
    Wait Until Element Is Visible   ${REGISTER_FORM}   20
    Wait Until Element Is Visible   ${REGISTER_EMAIL_FORM}   20    
    Click Element    ${REGISTER_EMAIL}
    ${result}=    Generate Random String
    Input Text   ${REGISTER_EMAIL}   ${result}${email}
    Input Text   ${REGISTER_FIRSTNAME}   ${firstname}    
    Input Text   ${REGISTER_LASTNAME}   ${lastname}
    Input Text   ${REGISTER_PASSWORD}   ${psw}
    Click Element   ${REGISTER_CREATE_ACCOUNT_BTN}
    Wait Until Element Is Not Visible   ${MENU_REGISTER}   20
    Wait Until Element Is Visible   ${WELCOME_DLG}    20
    Click Element   ${WELCOME_DLG} 
    Wait Until Element Is Not Visible   ${WELCOME_DLG}   20 
    Wait Until Element Is Visible   ${LOGIN_USER_ICON}     20
    Element Should Contain   ${USER_ACCOUNT_NAME}    Hi ${firstname}
    

Logout Page
    [Documentation]   A customer is able to logout from the website
    Go to  ${URL}
    Wait Until Element Is Visible   ${LOGIN_USER_ICON}   20
    Click Element   ${LOGIN_USER_ICON} 
    Wait Until Element Is Visible   ${USER_TOOLTIP}   20
    Wait Until Element Is Visible   ${LOGOUT_BTN}   20
    Click Element   ${LOGOUT_BTN}
    Wait Until Element Is Visible   ${MENU_LOGIN}   20
   
Add A Product With Any Category
    [Documentation]   A customer is able to add a product with any category by searching a product and then select
    [Arguments]      ${product}    ${size}  
    Wait Until Element Is Visible   ${SEARCH_BTN}    20
    Click Element   ${SEARCH_BTN}
    Wait Until Element Is Visible    ${SEARCH_FORM}   20
    Click Element   ${SEARCH_FIELD}
    Input Text     ${SEARCH_FIELD}   ${product} 
    Press Keys    ${SEARCH_FIELD}    ENTER
    Wait Until Element Is Visible    //div[@class='product-image__cover']//img[@alt='${product}']   20
    Click Element   //div[@class='product-image__hover']//img[@alt='${product}'] 
    Wait Until Element Is Visible   ${PRODUCT_DETAIL}    20
    Element Should Contain   ${PRODUCT_NAME}   ${product}
    Click Element    //div[contains(@class,'size-container')]//button[contains(text(),'${size}')]
    Wait Until Element Is Visible    ${ADD_TO_BAG_BTN}   20
    Click Element    ${ADD_TO_BAG_BTN}
    Wait Until Element Is Visible   ${ITEM_ADDED_BAG_DLG}   20
    Element Should Contain   ${ITEM_ADDED_PRODUCT_NAME}    ${product}
    Wait Until Element Is Visible   ${ITEM_ADDED_VIEW_SHOPPING_BAG_BTN}   20
    Click Element    ${ITEM_ADDED_CLOSE_BTN}
    Wait Until Element Is Not Visible   ${ITEM_ADDED_BAG_DLG}   20

Navigate To Cart Page
    [Documentation]   A customer is able to navigate to Cart page and see the added product
    Wait Until Element Is Visible   ${MENU_CART}   20
    Click Element   ${MENU_CART}
    Wait Until Element Is Visible   ${SHOPPING_BAG_DLG}   20
    Element Should Contain   ${SHOPPING_BAG_TITLE}    My Shopping Bag
    
Verify A Product In Shopping Bag
    [Documentation]   Verify the added product in shopping bag, verify product name, size and quantity
    [Arguments]    ${product}     ${size}    ${quantity}
    Wait Until Element Is Visible   ${SHOPPING_BAG_PRODUCT}   20
    Element Should Contain   ${SHOPPING_BAG_PRODUCT}   ${product}
    ${size_selected}=   Get Selected List Label   //div[contains(@class,'roduct-information') and div/div/a[contains(text(),'${product}')]]//div[contains(@class,'cart-item-info__size')]//select
    Should Be Equal    ${size_selected}   ${size}
    ${qutity_selected}=   Get Selected List Value   //div[contains(@class,'roduct-information') and div/div/a[contains(text(),'${product}')]]//div[@class='cart-item-info__quantity']//select
    Should Be Equal    ${qutity_selected}   ${quantity}

Adjust Quantity Of Procuct In Shopping Bag
    [Documentation]   A customer is able to adjust quantity of the product that they want by sending the product name and quantity in Shopping bag
    [Arguments]     ${product}   ${quantity} 
    Wait Until Element Is Visible   ${SHOPPING_BAG_PRODUCT}   20
    Select From List By Value   //div[contains(@class,'roduct-information') and div/div/a[contains(text(),'${product}')]]//div[@class='cart-item-info__quantity']//select   ${quantity}
    Wait Until Element Is Not Visible     ${SHOPPING_BAG_PRODUCT}    20
    Wait Until Element Is Visible     ${SHOPPING_BAG_PRODUCT}    20

Adjust Size Of Procuct In Shopping Bag    
    [Documentation]   A customer is able to adjust size of the product that they want by sending the product name and size in Shopping bag
    [Arguments]     ${product}     ${size} 
    Wait Until Element Is Visible   ${SHOPPING_BAG_PRODUCT}   20
    Select From List By Label   //div[contains(@class,'roduct-information') and div/div/a[contains(text(),'${product}')]]//div[contains(@class,'cart-item-info__size')]//select   ${size}
    Wait Until Element Is Visible     ${SHOPPING_BAG_PRODUCT}    20
    
Delete A Procuct In Shopping Bag 
    [Documentation]   A customer is able to delete a product in Shopping bag
    [Arguments]     ${product}     
    Wait Until Element Is Visible   ${SHOPPING_BAG_PRODUCT}   20
    Click Element   //div[contains(@class,'cart-product') and div//a[contains(text(),'${product}')]]//div[contains(@class,'cart-remove')]
    Wait Until Element Is Not Visible  //div[contains(@class,'cart-product') and div//a[contains(text(),'${product}')]]//div[contains(@class,'cart-remove')]  20
    Wait Until Element Is Visible   ${SHOPPING_BAG_PRODUCT}   20
    Element Should Not Contain   ${SHOPPING_BAG_PRODUCT}    ${product}

Enter Promo Code And Click Apply
    [Documentation]   A customer is able to apply Promo code
    [Arguments]     ${promo} 
    Wait Until Element Is Visible     ${SHOPPING_BAG_PROMO}   20
    Input Text    ${SHOPPING_BAG_PROMO}    ${promo}
    Click Element      ${SHOPPING_BAG_PROMO_APPLY}
       
Close Shopping Bag
    [Documentation]   A customer is able to click close Shopping bag
    Wait Until Element Is Visible  ${SHOPPING_BAG_CLOSE_BTN}   20
    Click Element   ${SHOPPING_BAG_CLOSE_BTN}
    Wait Until Element Is Not Visible   ${SHOPPING_BAG_DLG}
    
Proceed To Checkout
    [Documentation]   A customer is able to proceed to checkout and then navigate to checkout process page
    Wait Until Element Is Visible   ${SHOPPING_BAG_PROCEED_BTN}   20
    Click Element   ${SHOPPING_BAG_PROCEED_BTN} 
    Wait Until Element Is Visible   ${CHECKOUT_POMELO_LOGO}   20
    Wait Until Element Is Visible   ${CHECKOUT_SHIPPING}   20
    Element Should Contain   ${CHECKOUT_SHIPPING}   Shipping
    Element Should Contain   ${CHECKOUT_PAYMENT}   Payment
    Element Should Contain   ${CHECKOUT_CONFIRM}   Confirm
