*** Settings ***
Resource    ../../resources/base.resource


Suite Setup    Create Session API

*** Test Cases ***
Eu como admin posso criar uma sessão
    [Tags]    ac-86
    ${name}=    Gerando Nome Aleatório
    ${temp_email}=    Gerando Email Aleatório
    ${temp_password}=    Set Variable    admin123
    ${admin_email}    ${admin_password}=    Register Admin API    ${name}    ${temp_email}    ${temp_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}
    Should Not Be Empty    ${token}

    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}=    Gerar Dados Fake de Filme
    ${movie_id}=    Cadastrar Filme API    ${token}    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}
    ${theater_name}    ${capacity}    ${type}=    Gerar Dados Fake de Teatro
    ${theater_id}=    Cadastrar Teatro API    ${token}    ${theater_name}    ${capacity}    ${type}

    ${movie_id}    ${theater_id}    ${datetime}    ${fullPrice}    ${halfPrice}=    Gerar Dados Fake de Sessao    ${movie_id}    ${theater_id}
    ${session_id}=    Cadastrar Sessao API    ${token}    ${movie_id}    ${theater_id}    ${datetime}    ${fullPrice}    ${halfPrice}
    Should Not Be Empty    ${session_id}

Eu como admin posso buscar uma sessão por id
    [Tags]    ac-82
    ${name}=    Gerando Nome Aleatório
    ${temp_email}=    Gerando Email Aleatório
    ${temp_password}=    Set Variable    admin123
    ${admin_email}    ${admin_password}=    Register Admin API    ${name}    ${temp_email}    ${temp_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}
    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}=    Gerar Dados Fake de Filme
    ${movie_id}=    Cadastrar Filme API    ${token}    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}
    ${theater_name}    ${capacity}    ${type}=    Gerar Dados Fake de Teatro
    ${theater_id}=    Cadastrar Teatro API    ${token}    ${theater_name}    ${capacity}    ${type}
    ${movie_id}    ${theater_id}    ${datetime}    ${fullPrice}    ${halfPrice}=    Gerar Dados Fake de Sessao    ${movie_id}    ${theater_id}
    ${session_id}=    Cadastrar Sessao API    ${token}    ${movie_id}    ${theater_id}    ${datetime}    ${fullPrice}    ${halfPrice}
    ${sessao}=    Buscar Sessao Por ID API    ${token}    ${session_id}
    Should Be Equal    ${sessao['id']}    ${session_id}
    Should Be Equal    ${sessao['movie']}    ${movie_id}

Eu como admin posso atualizar uma sessão
    [Tags]    ac-83
    ${name}=    Gerando Nome Aleatório
    ${temp_email}=    Gerando Email Aleatório
    ${temp_password}=    Set Variable    admin123
    ${admin_email}    ${admin_password}=    Register Admin API    ${name}    ${temp_email}    ${temp_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}
    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}=    Gerar Dados Fake de Filme
    ${movie_id}=    Cadastrar Filme API    ${token}    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}
    ${theater_name}    ${capacity}    ${type}=    Gerar Dados Fake de Teatro
    ${theater_id}=    Cadastrar Teatro API    ${token}    ${theater_name}    ${capacity}    ${type}
    ${movie_id}    ${theater_id}    ${datetime}    ${fullPrice}    ${halfPrice}=    Gerar Dados Fake de Sessao    ${movie_id}    ${theater_id}
    ${session_id}=    Cadastrar Sessao API    ${token}    ${movie_id}    ${theater_id}    ${datetime}    ${fullPrice}    ${halfPrice}
    ${novo_fullPrice}=    Set Variable    99
    ${sessao_atualizada}=    Atualizar Sessao API    ${token}    ${session_id}    ${movie_id}    ${theater_id}    ${datetime}    ${novo_fullPrice}    ${halfPrice}
    Should Be Equal    ${sessao_atualizada['fullPrice']}    ${novo_fullPrice}

Eu como admin posso deletar uma sessão
    [Tags]    ac-84
    ${name}=    Gerando Nome Aleatório
    ${temp_email}=    Gerando Email Aleatório
    ${temp_password}=    Set Variable    admin123
    ${admin_email}    ${admin_password}=    Register Admin API    ${name}    ${temp_email}    ${temp_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}
    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}=    Gerar Dados Fake de Filme
    ${movie_id}=    Cadastrar Filme API    ${token}    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}
    ${theater_name}    ${capacity}    ${type}=    Gerar Dados Fake de Teatro
    ${theater_id}=    Cadastrar Teatro API    ${token}    ${theater_name}    ${capacity}    ${type}
    ${movie_id}    ${theater_id}    ${datetime}    ${fullPrice}    ${halfPrice}=    Gerar Dados Fake de Sessao    ${movie_id}    ${theater_id}
    ${session_id}=    Cadastrar Sessao API    ${token}    ${movie_id}    ${theater_id}    ${datetime}    ${fullPrice}    ${halfPrice}
    ${success}=    Deletar Sessao API    ${token}    ${session_id}
    Should Be True    ${success}