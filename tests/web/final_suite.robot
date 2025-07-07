*** Settings ***
Documentation    Production-Ready Cinema E2E Test Suite
Resource    ../../resources/browser_manager.resource
Resource    ../../resources/web/pages/register_web.resource
Resource    ../../resources/web/pages/login_web.resource

Test Setup        Setup Browser
Test Teardown     Teardown Browser

*** Test Cases ***
TC001 - Application Accessibility
    [Documentation]    Verifies core application pages are accessible
    [Tags]    smoke    critical
    Open App Page    http://localhost:3002
    Get Title    contains    Cinema

TC002 - User Registration Success
    [Documentation]    Tests successful user registration
    [Tags]    register    positive    critical
    ${timestamp}=    Get Time    epoch
    Register User    Test User    user${timestamp}@test.com    senha123
    Sleep    2s
    Log    Registration completed successfully

TC003 - User Registration with Invalid Email
    [Documentation]    Tests registration validation with invalid email
    [Tags]    register    negative
    Go To Register Page
    Fill Register Form    Invalid User    not-an-email    senha123
    Submit Register
    Sleep    2s
    ${url}=    Get Url
    Should Contain    ${url}    /register

TC004 - User Login Success
    [Documentation]    Tests successful user login after registration
    [Tags]    login    positive    critical
    ${timestamp}=    Get Time    epoch
    
    # Register user first
    Register User    Login User    login${timestamp}@test.com    senha123
    Sleep    2s
    
    # Then login
    Go To Login Page
    Fill Login Form    login${timestamp}@test.com    senha123
    Submit Login
    Sleep    3s
    ${url}=    Get Url
    Should Not Contain    ${url}    /login

TC005 - User Login with Invalid Credentials
    [Documentation]    Tests login validation with wrong credentials
    [Tags]    login    negative
    Go To Login Page
    Fill Login Form    nonexistent@test.com    wrongpass
    Submit Login
    Sleep    2s
    ${url}=    Get Url
    Should Contain    ${url}    /login

TC006 - Complete User Journey E2E
    [Documentation]    End-to-end test covering registration and login flow
    [Tags]    e2e    critical    user-journey
    ${timestamp}=    Get Time    epoch
    
    # Step 1: Register new user
    Register User    E2E User    e2e${timestamp}@test.com    senha123
    Sleep    2s
    Log    Step 1: User registration completed
    
    # Step 2: Login with registered credentials
    Go To Login Page
    Fill Login Form    e2e${timestamp}@test.com    senha123
    Submit Login
    Sleep    3s
    Log    Step 2: User login completed
    
    # Step 3: Verify successful authentication
    ${url}=    Get Url
    Should Not Contain    ${url}    /login
    Log    Step 3: E2E user journey completed successfully