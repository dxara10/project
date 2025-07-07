*** Settings ***
Library    Browser

*** Keywords ***
Setup Browser
    New Browser    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    Set Browser Timeout    10s

Teardown Browser
    Close Browser

Open App Page
    [Arguments]    ${url}
    New Page    ${url}
    Wait For Load State    networkidle    timeout=10s