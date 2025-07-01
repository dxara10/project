*** Settings ***
Resource    ../base.resource

*** Keywords ***
Get User By Id
    [Arguments]    ${token}    ${user_id}
    ${headers}=    Set Auth Header    ${token}
    ${response}=    GET On Session    cinema    /users/${user_id}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    200
    [Return]    ${response}

List Users
    [Arguments]    ${token}
    ${headers}=    Set Auth Header    ${token}
    ${response}=    GET On Session    cinema    /users    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    200
    [Return]    ${response}