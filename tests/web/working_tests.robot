*** Settings ***
Resource    ../../resources/browser_manager.resource
Resource    ../../resources/web/pages/login_web.resource
Resource    ../../resources/web/pages/register_web.resource

Suite Setup       Setup Browser
Suite Teardown    Teardown Browser

*** Test Cases ***
Register New User Successfully
    [Tags]    register    positive
    Register User    João Silva    joao.silva@test.com    senha123
    Sleep    2s
    ${url}=    Get Url
    Log    URL after register: ${url}

Login With Valid Credentials
    [Tags]    login    positive
    # First register a user
    Go To Register Page
    Fill Register Form    Maria Santos    maria@test.com    senha123
    Submit Register
    Sleep    2s
    
    # Then try to login
    Go To Login Page
    Fill Login Form    maria@test.com    senha123
    Submit Login
    Sleep    3s
    ${url}=    Get Url
    Log    URL after login: ${url}

Login With Invalid Credentials
    [Tags]    login    negative
    Go To Login Page
    Fill Login Form    invalid@test.com    wrongpass
    Submit Login
    Sleep    2s
    ${url}=    Get Url
    Should Contain    ${url}    /login

Complete User Flow
    [Tags]    e2e    user-flow
    # Register
    Register User    Pedro Costa    pedro@test.com    senha123
    Sleep    2s
    
    # Login
    Go To Login Page
    Fill Login Form    pedro@test.com    senha123
    Submit Login
    Sleep    3s
    
    # Verify we're logged in (not on login page)
    ${url}=    Get Url
    Should Not Contain    ${url}    /login