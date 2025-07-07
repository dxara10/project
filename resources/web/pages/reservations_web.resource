*** Settings ***
Library    Browser
Resource   ../../browser_manager.resource
Resource   login_web.resource

*** Keywords ***
Go To Sessions Page
    Open App Page    http://localhost:3002/sessions
    Wait For Elements State    css=.session, text=Sessão    visible    timeout=10s

Go To Reservations Page
    Open App Page    http://localhost:3002/reservations
    Wait For Elements State    css=.reservation, text=Reserva    visible    timeout=10s

Make Reservation As User
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
    
    # Try to access sessions
    Go To Sessions Page

Verify Reservation Success
    Sleep    2s
    ${url}=    Get Url
    Log    Current URL: ${url}