*** Settings ***
Resource    ../../resources/browser_manager.resource
Resource    ../../resources/web/pages/login_web.resource

Test Setup        Setup Browser
Test Teardown     Teardown Browser

*** Test Cases ***
Valid Login Test
    [Tags]    login    positive
    Go To Login Page
    Fill Login Form    admin@mail.com    admin123
    Submit Login
    Sleep    2s
    ${url}=    Get Url
    Should Not Contain    ${url}    /login

Invalid Login Test
    [Tags]    login    negative
    Go To Login Page
    Fill Login Form    invalid@test.com    wrongpass
    Submit Login
    Sleep    2s
    ${url}=    Get Url
    Should Contain    ${url}    /login