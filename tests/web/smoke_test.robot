*** Settings ***
Resource    ../../resources/browser_manager.resource
Resource    ../../resources/web/pages/login_web.resource
Resource    ../../resources/web/pages/register_web.resource
Resource    ../../resources/env.resource

Suite Setup       Setup Browser
Suite Teardown    Teardown Browser

*** Test Cases ***
App Is Running
    [Tags]    smoke
    Open App Page    http://localhost:3002
    Get Title    contains    Cinema

Login Page Loads
    [Tags]    smoke
    Go To Login Page

Register Page Loads
    [Tags]    smoke
    Go To Register Page

Basic Login Works
    [Tags]    smoke
    Login As Admin