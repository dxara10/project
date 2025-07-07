*** Settings ***
Resource    ../../resources/browser_manager.resource
Resource    ../../resources/web/pages/login_web.resource

Test Setup        Setup Browser
Test Teardown     Teardown Browser

*** Test Cases ***
TC001 - Sessions Page Access
    [Tags]    reservations    sessions
    ${timestamp}=    Get Time    epoch
    
    # Register user
    Open App Page    http://localhost:3002/register
    Wait For Elements State    css=#name    visible
    Fill Text    css=#name              User${timestamp}
    Fill Text    css=#email             user${timestamp}@test.com
    Fill Text    css=#password          senha123
    Fill Text    css=#confirmPassword   senha123
    Click    button[type="submit"]
    Sleep    2s
    
    # Login
    Go To Login Page
    Fill Login Form    user${timestamp}@test.com    senha123
    Submit Login
    Sleep    2s
    
    # Access sessions page
    Open App Page    http://localhost:3002/sessions
    Sleep    2s
    ${url}=    Get Url
    Should Contain    ${url}    /sessions

TC002 - Reservations Page Access
    [Tags]    reservations    user-reservations
    ${timestamp}=    Get Time    epoch
    
    # Register user
    Open App Page    http://localhost:3002/register
    Wait For Elements State    css=#name    visible
    Fill Text    css=#name              User${timestamp}
    Fill Text    css=#email             user${timestamp}@test.com
    Fill Text    css=#password          senha123
    Fill Text    css=#confirmPassword   senha123
    Click    button[type="submit"]
    Sleep    2s
    
    # Login
    Go To Login Page
    Fill Login Form    user${timestamp}@test.com    senha123
    Submit Login
    Sleep    2s
    
    # Access reservations page
    Open App Page    http://localhost:3002/reservations
    Sleep    2s
    ${url}=    Get Url
    Should Contain    ${url}    /reservations