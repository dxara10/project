*** Settings ***
Library    Browser
Resource   ../../browser_manager.resource
Resource   login_web.resource

*** Keywords ***
Go To Movies Page
    Open App Page    http://localhost:3002/movies
    Wait For Elements State    text=Filmes    visible    timeout=10s

Go To Add Movie Page
    Open App Page    http://localhost:3002/movies/register
    Wait For Elements State    input    visible    timeout=10s

Fill Movie Form
    [Arguments]    ${title}    ${director}    ${genre}    ${duration}
    ${inputs}=    Get Elements    input
    Fill Text    input >> nth=0    ${title}
    Fill Text    input >> nth=1    ${director}
    Fill Text    input >> nth=2    ${genre}
    Fill Text    input >> nth=3    ${duration}

Submit Movie
    Click    button[type="submit"]

Add Movie As Admin
    [Arguments]    ${title}    ${director}    ${genre}    ${duration}
    ${timestamp}=    Get Time    epoch
    
    # Register admin first
    Open App Page    http://localhost:3002/register
    Wait For Elements State    css=#name    visible
    Fill Text    css=#name              Admin${timestamp}
    Fill Text    css=#email             admin${timestamp}@test.com
    Fill Text    css=#password          admin123
    Fill Text    css=#confirmPassword   admin123
    Click    button[type="submit"]
    Sleep    2s
    
    # Login as admin
    Go To Login Page
    Fill Login Form    admin${timestamp}@test.com    admin123
    Submit Login
    Sleep    2s
    
    # Add movie
    Go To Add Movie Page
    Fill Movie Form    ${title}    ${director}    ${genre}    ${duration}
    Submit Movie

Verify Movie Success
    Sleep    2s
    ${url}=    Get Url
    Should Not Contain    ${url}    /register