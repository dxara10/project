*** Settings ***
Library           RequestsLibrary
Library           Collections

Resource          env.resource
Resource          api/auth.resource
Resource          api/movies.resource
Resource          api/theaters.resource
Resource          api/sessions.resource
Resource          api/users.resource
Resource          api/reservations.resource


*** Variables ***
${TOKEN}          None

*** Keywords ***
Create Session API
    Create Session    cinema    ${URL}    timeout=10

Set Auth Header
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    RETURN       ${headers}
