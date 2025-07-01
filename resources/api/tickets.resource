*** Settings ***
Resource    ../base.resource

*** Keywords ***
Purchase Ticket
    [Arguments]    ${token}    ${session_id}    ${seats_list}
    ${body}=    Create Dictionary    session=${session_id}    seats=${seats_list}
    ${headers}=    Set Auth Header    ${token}
    ${response}=    POST On Session    cinema    /tickets    json=${body}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201
    ${ticket_id}=    Set Variable    ${response.json()['data']['_id']}
    [Return]    ${ticket_id}