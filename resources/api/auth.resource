*** Settings ***
Library    FakerLibrary
Library    ../../venv/lib/python3.12/site-packages/robot/libraries/Telnet.py

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
    ${body}=    Create Dictionary    
    ...    name=${name}    
    ...    email=${email}    
    ...    password=${password}
    ${response}=    POST On Session    cinema    /auth/register    json=${body}
    Should Be True    ${response.status_code} in [200,201]
    [Return]    ${email}    ${password}

Register Admin API
    [Arguments]    ${name}    ${email}    ${password}
    ${body}=    Create Dictionary    
    ...    name=${name}    
    ...    email=${email}    
    ...    password=${password}
    ${response}=    POST On Session    cinema    /setup/admin    json=${body}
    Should Be True    ${response.status_code} in [200,201]
    [Return]    ${email}    ${password}

Login API
    [Arguments]    ${email}    ${password}
    ${body}=    Create Dictionary    
    ...    email=${email}    
    ...    password=${password}
    ${response}=    POST On Session    cinema    /auth/login    json=${body}
    Should Be Equal As Strings    ${response.status_code}    200
    ${token}=    Set Variable    ${response.json()['data']['token']}
    [Return]    ${token}

Update Password API
    [Arguments]    ${email}    ${old_password}    ${new_password}
    ${token}=    Login API    ${email}    ${old_password}
    ${headers}=    Create Dictionary    
    ...    Authorization=Bearer ${token}    
    ...    Content-Type=application/json
    ${body}=    Create Dictionary    password=${new_password}
    ${response}=    PUT    ${URL}/auth/profile    headers=${headers}    json=${body}
    Should Be Equal As Integers    ${response.status_code}    200    Falha ao atualizar senha!
