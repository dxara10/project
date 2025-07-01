*** Settings ***
Resource    ../base.resource

*** Keywords ***
Create Theater
    [Arguments]    ${token}
    ${body}=    Create Dictionary    name=Sala 1    capacity=100    type=IMAX
    ${headers}=    Set Auth Header    ${token}
    ${response}=    POST On Session    cinema    /theaters    json=${body}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201
    ${theater_id}=    Set Variable    ${response.json()['data']['_id']}
    [Return]    ${theater_id}