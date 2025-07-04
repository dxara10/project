*** Settings ***
Library    FakerLibrary
Library    ../../venv/lib/python3.12/site-packages/robot/libraries/DateTime.py
Resource    ../base.resource

*** Keywords ***
Create Session Cinema
    [Arguments]    ${token}    ${movie_id}    ${theater_id}
    ${body}=    Create Dictionary    movie=${movie_id}    theater=${theater_id}    date=2025-07-01T20:00:00Z
    ${headers}=    Set Auth Header    ${token}
    ${response}=    POST On Session    cinema    /sessions    json=${body}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201
    ${session_id}=    Set Variable    ${response.json()['data']['_id']}
    RETURN    ${session_id}

Gerar Dados Fake de Sessao
    [Arguments]    ${movie_id}    ${theater_id}
    # Generate a future date (tomorrow at 20:00)
    ${datetime}=    Get Current Date    increment=1 day    result_format=%Y-%m-%dT20:00:00.000Z
    ${fullPrice}=   Evaluate    random.randint(20, 50)
    ${halfPrice}=   Evaluate    random.randint(10, 25)
    RETURN    ${movie_id}    ${theater_id}    ${datetime}    ${fullPrice}    ${halfPrice}

# Criar sessão
Cadastrar Sessao API
    [Arguments]    ${token}    ${movie_id}    ${theater_id}    ${datetime}    ${fullPrice}    ${halfPrice}
    ${body}=    Create Dictionary
    ...    movie=${movie_id}
    ...    theater=${theater_id}
    ...    datetime=${datetime}
    ...    fullPrice=${fullPrice}
    ...    halfPrice=${halfPrice}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=    POST On Session    cinema    /sessions    headers=${headers}    json=${body}    expected_status=any
    Log    Session Creation - Status: ${response.status_code}
    Log    Session Creation - Content: ${response.content}
    Should Be Equal As Integers    ${response.status_code}    201
    ${json}=    To JSON    ${response.content}
    RETURN    ${json['data']['_id']}

# Buscar sessão por ID
Buscar Sessao Por ID API
    [Arguments]    ${token}    ${session_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    cinema    /sessions/${session_id}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    To JSON    ${response.content}
    RETURN    ${json['data']}

# Atualizar sessão
Atualizar Sessao API
    [Arguments]    ${token}    ${session_id}    ${movie_id}    ${theater_id}    ${datetime}    ${fullPrice}    ${halfPrice}
    ${body}=    Create Dictionary
    ...    movie=${movie_id}
    ...    theater=${theater_id}
    ...    datetime=${datetime}
    ...    fullPrice=${fullPrice}
    ...    halfPrice=${halfPrice}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=    PUT On Session    cinema    /sessions/${session_id}    headers=${headers}    json=${body}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    To JSON    ${response.content}
    RETURN    ${json['data']}

# Deletar sessão
Deletar Sessao API
    [Arguments]    ${token}    ${session_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    DELETE On Session    cinema    /sessions/${session_id}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    To JSON    ${response.content}
    RETURN    ${json['success']}

# Listar sessões
Listar Sessoes API
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    cinema    /sessions    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    To JSON    ${response.content}
    RETURN    ${json['data']}