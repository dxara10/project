*** Settings ***
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