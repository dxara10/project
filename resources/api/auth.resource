*** Settings ***
Library    FakerLibrary

Resource    ../base.resource

*** Keywords ***
Gerando Nome Aleatório
    ${name}     FakerLibrary.Name
    [Return]    ${name}

Gerando Email Aleatório
    ${email}    FakerLibrary.Email
    [Return]    ${email}

Register API
    [Arguments]    ${name}    ${email}    ${password}
    ${body}=    Create Dictionary    name=${name}    email=${email}    password=${password}
    ${response}=    POST On Session    cinema    /auth/register    json=${body}
    Should Be True    ${response.status_code} in [200,201]
    [Return]    ${email}    ${password}

Register Admin API
    [Arguments]    ${name}    ${email}    ${password}
    ${body}=    Create Dictionary    name=${name}    email=${email}    password=${password}
    ${response}=    POST On Session    cinema    /setup/admin    json=${body}
    Should Be True    ${response.status_code} in [200,201]
    [Return]    ${email}    ${password}

Login API
    [Arguments]    ${email}    ${password}
    ${body}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    cinema    /auth/login    json=${body}
    Should Be Equal As Strings    ${response.status_code}    200
    ${token}=    Set Variable    ${response.json()['data']['token']}
    [Return]    ${token}