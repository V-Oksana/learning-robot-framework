*** Settings ***
Documentation    Test Signup Happy Path
Library    SeleniumLibrary
Library    String
Library    FakerLibrary
Resource    utils.resource

Test Setup        Open the URL
Test Teardown        Close Browser


*** Variables ***



*** Test Cases ***        username        email        password        first_name        last_name
Sign up with valid credentials
    ${username}=    Get random username
    ${email}=    Get random email
    ${password}=    Get random password
    ${first_name}=    FakerLibrary.First Name
    ${last_name}=    FakerLibrary.Last Name
    Register a new user    ${username}    ${email}    ${password}    ${first_name}    ${last_name}


*** Keywords ***
Register a new user
    [Arguments]    ${username}    ${email}    ${password}    ${first_name}    ${last_name}
        # ON LOGIN OR SIGNUP PAGE
        Maximize Browser Window
        Click Link    /login
        Wait Until Location Is    ${url}/login
        Element Should Be Visible    class:signup-form
        Input Text    css:[data-qa="signup-name"]    ${username}
        Input Text    css:[data-qa="signup-email"]    ${email}
        Click Button    Signup

        # ON SIGNUP PAGE
        # ENTER ACCOUNT INFORMATION
        Wait Until Location Is    ${url}/signup
        ${options}=    Create List    id:id_gender1    id:id_gender2
        ${random_gender}=    Evaluate    random.choice(${options})    modules=random
        Click Element    ${random_gender}
        Input Text    css:[data-qa="password"]    ${password}
        Get random value from dropdown    css:[data-qa="days"]
        Get random value from dropdown    css:[data-qa="months"]
        Get random value from dropdown    css:[data-qa="years"]
        Scroll Element Into View    id:newsletter
        Select Checkbox    id:newsletter
        Select Checkbox    id:optin

        # ADDRESS INFORMATION
        Scroll Element Into View    css:[data-qa="first_name"]
        Input Text    css:[data-qa="first_name"]    ${first_name}
        Scroll Element Into View    css:[data-qa="last_name"]
        Input Text    css:[data-qa="last_name"]    ${last_name}

        ${company}=    FakerLibrary.Company
        Input Text    css:[data-qa="company"]    ${company}

        ${address}=    FakerLibrary.Address
        Input Text    css:[data-qa="address"]    ${address}

        ${address2}=    FakerLibrary.Secondary Address
        Input Text    css:[data-qa="address2"]    ${address2}

        Scroll Element Into View    css:[data-qa="country"]
        Get random value from dropdown    css:[data-qa="country"]
        ${state}=    FakerLibrary.State
        Input Text    css:[data-qa="state"]    ${state}

        ${city}=    FakerLibrary.City
        Input Text    css:[data-qa="city"]    ${city}

        ${zip}=    FakerLibrary.Zipcode
        Input Text    css:[data-qa="zipcode"]    ${zip}

        ${mobile_number}=    FakerLibrary.Basic Phone Number
        Input Text    css:[data-qa="mobile_number"]    ${mobile_number}

        Scroll Element Into View    css:[data-qa="create-account"]
        Click Button    Create Account

        # ON ACCOUNT CREATED PAGE
        Location Should Be    ${url}/account_created
        Element Should Be Visible    css:[data-qa="account-created"]
        Title Should Be    Automation Exercise - Account Created
        Click Element    css:[data-qa="continue-button"]
        Page Should Contain    Logged in as ${username}

        # DEBUG MESSAGE
        Log    Test Completed! User ${first_name} ${last_name} with username ${username} is created and logged in!


