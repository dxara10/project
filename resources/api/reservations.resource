*** Settings ***
Library    FakerLibrary
Resource    ../base.resource

*** Keywords ***
Gerar Dados Fake de Reserva
    [Documentation]    Gera e retorna apenas os dados que são realmente FAKES para uma reserva.
    # Os assentos são gerados como uma lista de dicionários, conforme o Postman.
    ${seat1}=    Create Dictionary    row=A    number=1
    ${seat2}=    Create Dictionary    row=A    number=2
    ${seats}=    Create List    ${seat1}    ${seat2}
    ${ticketType}=    Set Variable    full
    RETURN    ${seats}    ${ticketType}

Cadastrar Reserva API
    [Arguments]    ${token}    ${session_id}    ${seats}    ${ticketType}
    [Documentation]    Keyword para encapsular a criação de uma reserva.
    ${body}=    Create Dictionary    session=${session_id}    seats=${seats}    paymentMethod=pix
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    POST On Session    cinema    /reservations    headers=${headers}    json=${body}    expected_status=any
    RETURN    ${response}

Buscar Reserva Por ID API
    [Arguments]    ${token}    ${reservation_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    cinema    /reservations/${reservation_id}    headers=${headers}    expected_status=any
    RETURN    ${response}

Listar Minhas Reservas API
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    cinema    /reservations/me    headers=${headers}    expected_status=any
    RETURN    ${response}

Atualizar Reserva API
    [Arguments]    ${token}    ${reservation_id}    ${status}=None
    ${body}=    Create Dictionary
    Run Keyword If    '${status}' != 'None'    Set To Dictionary    ${body}    status=${status}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    PUT On Session    cinema    /reservations/${reservation_id}    headers=${headers}    json=${body}    expected_status=any
    RETURN    ${response}

Deletar Reserva API
    [Arguments]    ${token}    ${reservation_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    DELETE On Session    cinema    /reservations/${reservation_id}    headers=${headers}
    RETURN    ${response}

Listar Todas Reservas API (Admin)
    [Arguments]    ${admin_token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${admin_token}
    ${response}=    GET On Session    cinema    /reservations    headers=${headers}
    RETURN    ${response}