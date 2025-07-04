*** Settings ***
Resource    ../../resources/base.resource

Suite Setup    Preparar Suite Completa

*** Keywords ***
Preparar Suite Completa
    Create Session API
    Preparar Ambiente Para Testes de Reserva

Preparar Ambiente Para Testes de Reserva
    [Documentation]    Cria todos os dados necessários (usuário, admin, filme, etc.) UMA VEZ SÓ.
    ${admin_name}    ${admin_email}    ${admin_password}=    Gerar Dados Fake de Usuario
    Register Admin API    ${admin_name}    ${admin_email}    ${admin_password}
    ${admin_token}=    Login API    ${admin_email}    ${admin_password}

    ${user_name}    ${user_email}    ${user_password}=    Gerar Dados Fake de Usuario
    ${user_id}=    Cadastrar Usuario API    ${user_name}    ${user_email}    ${user_password}
    ${user_token}=    Login API    ${user_email}    ${user_password}

    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}=    Gerar Dados Fake de Filme
    ${movie_id}=    Cadastrar Filme API    ${admin_token}    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}

    ${theater_name}    ${capacity}    ${type}=    Gerar Dados Fake de Teatro
    ${theater_id}=    Cadastrar Teatro API    ${admin_token}    ${theater_name}    ${capacity}    ${type}

    ${movie_id}    ${theater_id}    ${datetime}    ${fullPrice}    ${halfPrice}=    Gerar Dados Fake de Sessao    ${movie_id}    ${theater_id}
    ${session_id}=    Cadastrar Sessao API    ${admin_token}    ${movie_id}    ${theater_id}    ${datetime}    ${fullPrice}    ${halfPrice}

    Set Suite Variable    ${USER_TOKEN}       ${user_token}
    Set Suite Variable    ${ADMIN_TOKEN}      ${admin_token}
    Set Suite Variable    ${SESSION_ID}       ${session_id}
    Set Suite Variable    ${USER_ID_TO_DELETE}    ${user_id}

Limpar Ambiente dos Testes de Reserva
    [Documentation]    Deleta o usuário comum criado para os testes. O admin se mantém.
    Deletar Usuario API    ${ADMIN_TOKEN}    ${USER_ID_TO_DELETE}

*** Test Cases ***
Eu posso criar uma reserva
    ${seats}    ${ticketType}=    Gerar Dados Fake de Reserva
    ${response}=    Cadastrar Reserva API    ${USER_TOKEN}    ${SESSION_ID}    ${seats}    ${ticketType}
    Should Be Equal As Integers    ${response.status_code}    201
    ${json}=    To JSON    ${response}
    Should Not Be Empty    ${json['data']['_id']}
    Deletar Reserva API    ${USER_TOKEN}    ${json['data']['_id']}

Eu posso buscar uma reserva por id
    ${seats}    ${ticketType}=    Gerar Dados Fake de Reserva
    ${response_create}=    Cadastrar Reserva API    ${USER_TOKEN}    ${SESSION_ID}    ${seats}    ${ticketType}
    ${json_create}=    To JSON    ${response_create}
    ${reservation_id}=    Set Variable    ${json_create['data']['_id']}

    ${response_get}=    Buscar Reserva Por ID API    ${USER_TOKEN}    ${reservation_id}
    Should Be Equal As Integers    ${response_get.status_code}    200
    ${json_get}=    To JSON    ${response_get}
    Should Be Equal    ${json_get['data']['_id']}    ${reservation_id}
    Deletar Reserva API    ${USER_TOKEN}    ${reservation_id}

Eu posso listar minhas reservas
    ${seats}    ${ticketType}=    Gerar Dados Fake de Reserva
    ${response_create}=    Cadastrar Reserva API    ${USER_TOKEN}    ${SESSION_ID}    ${seats}    ${ticketType}
    ${json_create}=    To JSON    ${response_create}
    ${reservation_id}=    Set Variable    ${json_create['data']['_id']}

    ${response}=    Listar Minhas Reservas API    ${USER_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    To JSON    ${response}
    Should Not Be Empty    ${json['data']}
    Deletar Reserva API    ${USER_TOKEN}    ${reservation_id}

Eu posso cancelar uma reserva (atualizar status)
    ${seats}    ${ticketType}=    Gerar Dados Fake de Reserva
    ${response_create}=    Cadastrar Reserva API    ${USER_TOKEN}    ${SESSION_ID}    ${seats}    ${ticketType}
    ${json_create}=    To JSON    ${response_create}
    ${reservation_id}=    Set Variable    ${json_create['data']['_id']}

    ${response}=    Atualizar Reserva API    ${USER_TOKEN}    ${reservation_id}    status=cancelled
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    To JSON    ${response}
    Should Be Equal    ${json['data']['status']}    cancelled
    Deletar Reserva API    ${USER_TOKEN}    ${reservation_id}

Eu posso deletar uma reserva
    ${seats}    ${ticketType}=    Gerar Dados Fake de Reserva
    ${response_create}=    Cadastrar Reserva API    ${USER_TOKEN}    ${SESSION_ID}    ${seats}    ${ticketType}
    ${json_create}=    To JSON    ${response_create}
    ${reservation_id}=    Set Variable    ${json_create['data']['_id']}

    ${response}=    Deletar Reserva API    ${USER_TOKEN}    ${reservation_id}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    To JSON    ${response}
    Should Be True    ${json['success']}

Admin pode listar todas as reservas
    ${seats}    ${ticketType}=    Gerar Dados Fake de Reserva
    ${response_create}=    Cadastrar Reserva API    ${USER_TOKEN}    ${SESSION_ID}    ${seats}    ${ticketType}
    ${json_create}=    To JSON    ${response_create}
    ${reservation_id}=    Set Variable    ${json_create['data']['_id']}

    ${response}=    Listar Todas Reservas API (Admin)    ${ADMIN_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    To JSON    ${response}
    Should Not Be Empty    ${json['data']}
    Deletar Reserva API    ${USER_TOKEN}    ${reservation_id}