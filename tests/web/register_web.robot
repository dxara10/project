*** Settings ***
Resource    ../../resources/browser_manager.resource
Resource    ../../resources/web/pages/register_web.resource

Test Setup        Setup Browser
Test Teardown     Teardown Browser

*** Test Cases ***
Valid Registration Test
    [Tags]    register    positive
    Register User    João Silva    joao${RANDOM}@test.com    senha123
    Sleep    2s
    ${url}=    Get Url
    Log    Registration completed, URL: ${url}

Invalid Email Registration Test
    [Tags]    register    negative
    Go To Register Page
    Fill Register Form    Maria    invalid-email    senha123
    Submit Register
    Sleep    2s
    ${url}=    Get Url
    Should Contain    ${url}    /register