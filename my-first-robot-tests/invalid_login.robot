*** Settings ***
Documentation        TestDemo
Test Setup        Open the URL
Test Teardown        Close Browser
Test Template        Login with invalid email
Library        SeleniumLibrary
Resource        utils.resource

*** Variables ***
${password}    Test1234

*** Test Cases ***                username                expected_error
Email missing 'at'                 no-at.test              Please include an '@' in the email address.
Email missing domain               invalid1                Please include an '@' in the email address.
Special chars in domain            invalid@#$%.com         A part following '@' should not contain the symbol
Empty email                        ${EMPTY}                Please fill out this field.


*** Keywords ***
Login with invalid email
    [Arguments]        ${username}        ${expected_error}
        Maximize Browser Window
        Click Link    /login
        Wait Until Location Is    ${url}/login
        Element Should Be Visible    class:login-form
        Input Text    css:[data-qa="login-email"]    ${username}
        Input Text    css:[data-qa="login-password"]    ${password}
        Click Button    css:[data-qa="login-button"]
        # Execute Javascript to extract the browser's internal validation message
        ${error_message}=    Extract browser error message    data-qa="login-email"
        Should Contain    ${error_message}    ${expected_error}



