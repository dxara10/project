*** Settings ***
Library    Browser
Resource   ../../browser_manager.resource

*** Keywords ***
Go To Register Page
    Open App Page    http://localhost:3002/register
    Wait For Elements State    css=#name    visible    timeout=10s

Fill Register Form
    [Arguments]    ${name}    ${email}    ${password}
    Fill Text    css=#name              ${name}
    Fill Text    css=#email             ${email}
    Fill Text    css=#password          ${password}
    Fill Text    css=#confirmPassword   ${password}

Submit Register
    Click    button[type="submit"]

Register User
    [Arguments]    ${name}    ${email}    ${password}
    Go To Register Page
    Fill Register Form    ${name}    ${email}    ${password}
    Submit Register

Verify Register Success
    Wait For Elements State    text=sucesso    visible    timeout=5s

Verify Register Error
    Wait For Elements State    css=.error, css=.alert    visible    timeout=5s