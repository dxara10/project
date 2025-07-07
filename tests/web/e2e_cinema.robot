*** Settings ***
Resource    ../../resources/browser_manager.resource
Resource    ../../resources/web/pages/register_web.resource
Resource    ../../resources/web/pages/login_web.resource

Test Setup        Setup Browser
Test Teardown     Teardown Browser

*** Test Cases ***
Complete User Registration and Login Flow
    [Tags]    e2e    critical
    ${random}=    Evaluate    str(__import__('random').randint(1000, 9999))
    
    # Step 1: Register new user
    Register User    User E2E    user${random}@test.com    senha123
    Sleep    2s
    
    # Step 2: Login with registered user
    Go To Login Page
    Fill Login Form    user${random}@test.com    senha123
    Submit Login
    Sleep    3s
    
    # Step 3: Verify successful login
    ${url}=    Get Url
    Should Not Contain    ${url}    /login
    Log    E2E Flow completed successfully