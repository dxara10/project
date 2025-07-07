*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           Browser

Resource          env.resource

*** Variables ***
${TOKEN}          None

*** Keywords ***
Create Session API
    Create Session    cinema    ${URL}    timeout=20

Set Auth Header
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    RETURN       ${headers}