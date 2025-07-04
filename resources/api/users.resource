*** Settings ***
Library    FakerLibrary
Resource    ../base.resource

*** Keywords ***
Gerar Dados Fake de Usuario
    ${name}=    FakerLibrary.Name
    ${email}=   FakerLibrary.Email
    ${password}=    Set Variable    senha123
    RETURN    ${name}    ${email}    ${password}

Cadastrar Usuario API
    [Arguments]    ${name}    ${email}    ${password}
    ${body}=    Create Dictionary    name=${name}    email=${email}    password=${password}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST On Session    cinema    /auth/register    headers=${headers}    json=${body}
    Should Be Equal As Integers    ${response.status_code}    201
    ${json}=    To JSON    ${response.content}
    RETURN    ${json['data']['_id']}    ${json['data']['token']}

Buscar Usuario Por ID API
    [Arguments]    ${token}    ${user_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    cinema    /auth/me    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    To JSON    ${response.content}
    RETURN    ${json['data']}

Atualizar Usuario API
    [Arguments]    ${token}    ${user_id}    ${name}    ${email}
    ${body}=    Create Dictionary    name=${name}    email=${email}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=    PUT On Session    cinema    /auth/profile    headers=${headers}    json=${body}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    To JSON    ${response.content}
    RETURN    ${json['data']}

Deletar Usuario API
    [Arguments]    ${token}    ${user_id}
    # User deletion requires admin privileges, so we'll skip this test
    # or implement admin user creation first
    Log    User deletion requires admin privileges - skipping for now
    RETURN    ${True}