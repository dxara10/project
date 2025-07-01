*** Settings ***
Resource    ../base.resource

*** Keywords ***
Get Session Seats
    [Arguments]    ${token}    ${session_id}
    ${headers}=    Set Auth Header    ${token}
    ${response}=    GET On Session    cinema    /sessions/${session_id}/seats    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    200
    [Return]    ${response}