*** Settings ***
Library    FakerLibrary
Library    ../../venv/lib/python3.12/site-packages/robot/libraries/DateTime.py
Resource    ../base.resource

*** Keywords ***
Create Session
    [Arguments]    ${token}    ${movie_id}    ${theater_id}
    ${body}=    Create Dictionary    movie=${movie_id}    theater=${theater_id}    date=2025-07-01T20:00:00Z
    ${headers}=    Set Auth Header    ${token}
    ${response}=    POST On Session    cinema    /sessions    json=${body}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201
    ${session_id}=    Set Variable    ${response.json()['data']['_id']}
    [Return]    ${session_id}

Gerar Dados Fake de Sessao
    [Arguments]    ${movie_id}    ${theater_id}
    ${datetime}=    Get Current Date    result_format=%Y-%m-%dT%H:%M:%S.000Z
    ${fullPrice}=   Evaluate    random.randint(20, 50)
    ${halfPrice}=   Evaluate    random.randint(10, 25)
    [Return]    ${movie_id}    ${theater_id}    ${datetime}    ${fullPrice}    ${halfPrice}

Cadastrar Sessao API
    [Arguments]    ${token}    ${movie_id}    ${theater_id}    ${datetime}    ${fullPrice}    ${halfPrice}
    ${body}=    Create Dictionary
    ...    movie=${movie_id}
    ...    theater=${theater_id}
    ...    datetime=${datetime}
    ...    fullPrice=${fullPrice}
    ...    halfPrice=${halfPrice}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=    POST On Session    cinema    /sessions    headers=${headers}    json=${body}
    Should Be Equal As Integers    ${response.status_code}    201
    ${json}=    To JSON    ${response.content}
    [Return]    ${json['data']['id']}