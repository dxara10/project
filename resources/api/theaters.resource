*** Settings ***
Library    FakerLibrary
Resource    ../base.resource

*** Keywords ***
Create Theater
    [Arguments]    ${token}
    ${name}=        FakerLibrary.Word
    ${capacity}=    Evaluate    random.randint(50, 200)
    ${type}=        Set Variable    standard
    ${body}=    Create Dictionary    name=${name}    capacity=${capacity}    type=${type}
    ${headers}=    Set Auth Header    ${token}
    ${response}=    POST On Session    cinema    /theaters    json=${body}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201
    ${theater_id}=    Set Variable    ${response.json()['data']['_id']}
    [Return]    ${theater_id}