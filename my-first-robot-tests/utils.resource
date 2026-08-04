*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections

*** Variables ***
${url}    https://automationexercise.com
${browser}    Chrome

*** Keywords ***
Open the URL
    Open Browser    ${url}    ${browser}

Get random string
    [Arguments]    ${length}=10    ${characters}=[LETTERS]    ${prefix}=${EMPTY}    ${suffix}=${EMPTY}
    ${random_part}=    Generate Random String    ${length}    ${characters}
    ${final_string}=    Catenate    SEPARATOR=    ${prefix}    ${random_part}    ${suffix}
    RETURN    ${final_string}

Get random username
    ${random_username}=    Get random string    length=8    characters=[LETTERS][NUMBERS]    prefix=user_    suffix=${EMPTY}
    RETURN    ${random_username}

Get random password
    ${random_password}=    Get random string    length=12    characters=[LETTERS][NUMBERS]!@#$%^&*()    prefix=pass_    suffix=${EMPTY}
    RETURN    ${random_password}

Get random email
    ${random_email}=    Get random string    length=10    characters=[LOWER][NUMBERS]    prefix=email_    suffix=@robottest.com
    RETURN    ${random_email}

Get random value from dropdown
    [Arguments]    ${list_id}
    ${all_options}=     Get List Items    ${list_id}
    Remove From List    ${all_options}    0
    ${random_value}=    Evaluate    random.choice(${all_options})    modules=random
    Select From List By Label    ${list_id}    ${random_value}
    RETURN    ${random_value}