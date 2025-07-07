*** Settings ***
Resource    ../../resources/browser_manager.resource

Suite Setup       Setup Browser
Suite Teardown    Teardown Browser

*** Test Cases ***
Debug Login Page
    [Tags]    debug
    Open App Page    http://localhost:3002/login
    Sleep    3s
    Take Screenshot    login_debug
    ${inputs}=    Get Elements    input
    Log    Found ${inputs.__len__()} input elements
    ${buttons}=    Get Elements    button
    Log    Found ${buttons.__len__()} button elements

Debug Register Page
    [Tags]    debug
    Open App Page    http://localhost:3002/register
    Sleep    3s
    Take Screenshot    register_debug
    ${inputs}=    Get Elements    input
    Log    Found ${inputs.__len__()} input elements