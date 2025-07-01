*** Settings ***
Resource    ../base.resource

*** Keywords ***
Create Movie
    [Arguments]    ${token}
    ${body}=    Create Dictionary    title=Test Movie    description=Test Desc    year=2025    director=Test Director    duration=120
    ${headers}=    Set Auth Header    ${token}
    ${response}=    POST On Session    cinema    /movies    json=${body}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201
    ${movie_id}=    Set Variable    ${response.json()['data']['_id']}
    [Return]    ${movie_id}