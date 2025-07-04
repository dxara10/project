*** Settings ***
Resource    ../../resources/base.resource
Resource    ../../resources/api/movies.resource
Resource    ../../resources/api/auth.resource

Suite Setup    Create Session API


*** Test Cases ***
Eu como novo admin posso cadastrar um filme
    ${name}=    Gerando Nome Aleatório
    ${admin_email}=   Gerando Email Aleatório
    ${admin_password}=    Set Variable    admin123

    Register Admin API    ${name}    ${admin_email}    ${admin_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}

    Set Suite Variable    ${admin_email}
    Set Suite Variable    ${admin_password}

    Log    ${token}
    Should Not Be Empty    ${token}    Token do admin foi retornado!
    
    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}=    Gerar Dados Fake de Filme
    ${movie_id}=    Cadastrar Filme API    ${token}    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}
    Should Not Be Empty    ${movie_id}

Eu como admin posso buscar um filme por id
    ${name}=    Gerando Nome Aleatório
    ${admin_email}=   Gerando Email Aleatório
    ${admin_password}=    Set Variable    admin123
    Register Admin API    ${name}    ${admin_email}    ${admin_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}
    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}=    Gerar Dados Fake de Filme
    ${movie_id}=    Cadastrar Filme API    ${token}    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}
    ${filme}=    Buscar Filme Por ID API    ${token}    ${movie_id}
    Should Be Equal    ${filme['id']}    ${movie_id}
    Should Be Equal    ${filme['title']}    ${title}

Eu como admin posso atualizar um filme
    ${name}=    Gerando Nome Aleatório
    ${admin_email}=   Gerando Email Aleatório
    ${admin_password}=    Set Variable    admin123
    Register Admin API    ${name}    ${admin_email}    ${admin_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}
    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}=    Gerar Dados Fake de Filme
    ${movie_id}=    Cadastrar Filme API    ${token}    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}
    ${novo_title}=    Set Variable    Filme Atualizado
    ${filme_atualizado}=    Atualizar Filme API    ${token}    ${movie_id}    ${novo_title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}
    Should Be Equal    ${filme_atualizado['title']}    ${novo_title}

Eu como admin posso deletar um filme
    ${name}=    Gerando Nome Aleatório
    ${admin_email}=   Gerando Email Aleatório
    ${admin_password}=    Set Variable    admin123
    Register Admin API    ${name}    ${admin_email}    ${admin_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}
    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}=    Gerar Dados Fake de Filme
    ${movie_id}=    Cadastrar Filme API    ${token}    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}
    ${success}=    Deletar Filme API    ${token}    ${movie_id}
    Should Be True    ${success}