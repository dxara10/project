*** Settings ***
Library    Browser
Resource   ../../browser_manager.resource
Resource   ../../env.resource

*** Keywords ***
Go To Login Page
    Open App Page    http://localhost:3002/login
    Wait For Elements State    css=#email    visible    timeout=10s

Fill Login Form
    [Arguments]    ${email}    ${password}
    Fill Text    css=#email       ${email}
    Fill Text    css=#password    ${password}

Submit Login
    Click    button[type="submit"]

Login As Admin
    Go To Login Page
    Fill Login Form    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    Submit Login
    Verify Login Success

Verify Login Success
    Sleep    3s
    ${url}=    Get Url
    Log    Current URL after login: ${url}
    TRY
        # Check if redirected away from login
        Should Not Contain    ${url}    /login
    EXCEPT
        # Alternative: check for success indicators
        TRY
            Wait For Elements State    text=Bem-vindo    visible    timeout=2s
        EXCEPT
            TRY
                Wait For Elements State    text=Dashboard    visible    timeout=2s
            EXCEPT
                # Check if login form is gone (successful login)
                ${login_forms}=    Get Elements    css=#email
                Should Be Equal    ${login_forms.__len__()}    ${0}
            END
        END
    END

Verify Login Error
    Wait For Elements State    css=.error, css=.alert    visible    timeout=5s

Logout User
    Click    text=Sair

Verify At Login Page
    Wait For Elements State    css=#email    visible    timeout=10s