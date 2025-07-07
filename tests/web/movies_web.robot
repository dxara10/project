*** Settings ***
Resource    ../../resources/browser_manager.resource
Resource    ../../resources/web/pages/login_web.resource

Test Setup        Setup Browser
Test Teardown     Teardown Browser

*** Test Cases ***
TC001 - Movies Page Access
    [Tags]    movies    access
    ${timestamp}=    Get Time    epoch
    
    # Register admin
    Open App Page    http://localhost:3002/register
    Wait For Elements State    css=#name    visible
    Fill Text    css=#name              Admin${timestamp}
    Fill Text    css=#email             admin${timestamp}@test.com
    Fill Text    css=#password          admin123
    Fill Text    css=#confirmPassword   admin123
    Click    button[type="submit"]
    Sleep    2s
    
    # Login
    Go To Login Page
    Fill Login Form    admin${timestamp}@test.com    admin123
    Submit Login
    Sleep    2s
    
    # Access movies page
    Open App Page    http://localhost:3002/movies
    Sleep    2s
    ${url}=    Get Url
    Should Contain    ${url}    /movies

TC002 - Add Movie Page Access
    [Tags]    movies    add-movie
    ${timestamp}=    Get Time    epoch
    
    # Register admin
    Open App Page    http://localhost:3002/register
    Wait For Elements State    css=#name    visible
    Fill Text    css=#name              Admin${timestamp}
    Fill Text    css=#email             admin${timestamp}@test.com
    Fill Text    css=#password          admin123
    Fill Text    css=#confirmPassword   admin123
    Click    button[type="submit"]
    Sleep    2s
    
    # Login
    Go To Login Page
    Fill Login Form    admin${timestamp}@test.com    admin123
    Submit Login
    Sleep    2s
    
    # Access add movie page
    Open App Page    http://localhost:3002/movies/register
    Sleep    2s
    ${url}=    Get Url
    Should Contain    ${url}    /movies