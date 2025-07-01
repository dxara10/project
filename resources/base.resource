*** Settings ***
Library           RequestsLibrary
Library           Collections

Resource          env.resource
Resource          api/auth.resource

*** Variables ***
${TOKEN}          None

*** Keywords ***
Create Session API
    Create Session    cinema    ${URL}    timeout=10

Set Auth Header
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    [Return]       ${headers}