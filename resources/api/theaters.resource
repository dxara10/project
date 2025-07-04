*** Settings ***
Library    FakerLibrary
Resource    ../base.resource

*** Keywords ***
Gerar Dados Fake de Teatro
    ${name}=        FakerLibrary.Word
    ${capacity}=    Evaluate    random.randint(50, 200)
    ${type}=        Set Variable    standard
    RETURN    ${name}    ${capacity}    ${type}

Cadastrar Teatro API
    [Arguments]    ${token}    ${name}    ${capacity}    ${type}
    ${body}=    Create Dictionary    name=${name}    capacity=${capacity}    type=${type}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=    POST On Session    cinema    /theaters    headers=${headers}    json=${body}
    Should Be Equal As Integers    ${response.status_code}    201
    ${json}=    To JSON    ${response.content}
    RETURN    ${json['data']['id']}

Buscar Teatro Por ID API
    [Arguments]    ${token}    ${theater_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    cinema    /theaters/${theater_id}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    To JSON    ${response.content}
    RETURN    ${json['data']}

Atualizar Teatro API
    [Arguments]    ${token}    ${theater_id}    ${name}    ${capacity}    ${type}
    ${body}=    Create Dictionary    name=${name}    capacity=${capacity}    type=${type}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=    PUT On Session    cinema    /theaters/${theater_id}    headers=${headers}    json=${body}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    To JSON    ${response.content}
    RETURN    ${json['data']}

Deletar Teatro API
    [Arguments]    ${token}    ${theater_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    DELETE On Session    cinema    /theaters/${theater_id}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    To JSON    ${response.content}
    RETURN    ${json['success']}