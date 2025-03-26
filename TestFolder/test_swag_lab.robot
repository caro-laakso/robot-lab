*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Teardown     Capture Page Screenshot

*** Variables ***
*** Variables ***
${BROWSER}        ${BROWSER_OVERRIDE}
${BROWSER_OVERRIDE}    Chrome
${URL}            file:///C:/Users/Carolina/Downloads/swag_labs%20(1).html
${USERNAME}       standard_user
${PASSWORD}       secret_sauce
${FIRST_NAME}     Topsis
${LAST_NAME}      Topsonen
${ZIP_CODE}       12345

*** Keywords ***
Open Browser To Login Page
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --window-size=1920,1080
    Open Browser    ${URL}    chrome    options=${options}
    Maximize Browser Window
    Set Selenium Speed    0.5s


Login To Application
    Input Text    id=username    ${USERNAME}
    Input Text    id=password     ${PASSWORD}
    Click Button  id=login-button
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[1]/h1

Add Items To Cart
    Click Button    xpath=/html/body/div[2]/div[2]/div[1]/button
    Click Button    xpath=/html/body/div[2]/div[2]/div[2]/button
    Click Button    xpath=/html/body/div[2]/div[2]/div[3]/button

Go To Checkout And Remove Item
    Click Element    xpath=/html/body/div[2]/div[1]/div/div
    Wait Until Element Is Visible    xpath=/html/body/div[3]/h2
    Click Button    xpath=/html/body/div[3]/div[1]/div[1]/button

Fill Out Checkout Info
    Input Text    id=first-name    ${FIRST_NAME}
    Input Text    id=last-name     ${LAST_NAME}
    Input Text    id=postal-code   ${ZIP_CODE}
    Click Button  xpath=/html/body/div[3]/div[2]/button


Verify Success Message
    Wait Until Element Is Visible    xpath=/html/body/div[4]/h2

*** Test Cases ***
Test End-To-End Swag Labs Purchase Flow
    Login To Application
    Add Items To Cart
    Go To Checkout And Remove Item
    Fill Out Checkout Info
    Verify Success Message
