*** Settings ***
Library    FakerLibrary
Library    Telnet

Resource    ../base.resource

*** Keywords ***
Gerando Nome Aleatório
    ${name}     FakerLibrary.Name
    RETURN    ${name}

Gerando Email Aleatório
    ${email}    FakerLibrary.Email
    RETURN    ${email}

Register API
    [Arguments]    ${name}    ${email}    ${password}
    ${body}=    Create Dictionary    
    ...    name=${name}    
    ...    email=${email}    
    ...    password=${password}
    ${response}=    POST On Session    cinema    /auth/register    json=${body}
    Should Be True    ${response.status_code} in [200,201]
    RETURN    ${email}    ${password}

Register Admin API
    [Arguments]    ${name}    ${email}    ${password}
    ${body}=    Create Dictionary    
    ...    name=${name}    
    ...    email=${email}    
    ...    password=${password}
    ${response}=    POST On Session    cinema    /setup/admin    json=${body}
    Should Be True    ${response.status_code} in [200,201]
    RETURN    ${email}    ${password}

Login API
    [Arguments]    ${email}    ${password}
    ${body}=    Create Dictionary    
    ...    email=${email}    
    ...    password=${password}
    ${response}=    POST On Session    cinema    /auth/login    json=${body}
    Should Be Equal As Strings    ${response.status_code}    200
    ${token}=    Set Variable    ${response.json()['data']['token']}
    RETURN    ${token}

Update Password API
    [Arguments]    ${email}    ${old_password}    ${new_password}
    ${token}=    Login API    ${email}    ${old_password}
    ${headers}=    Create Dictionary    
    ...    Authorization=Bearer ${token}    
    ...    Content-Type=application/json
    ${body}=    Create Dictionary    password=${new_password}
    ${response}=    PUT On Session    cinema    /auth/profile    headers=${headers}    json=${body}
    Should Be Equal As Integers    ${response.status_code}    200
