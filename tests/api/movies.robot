*** Settings ***
Resource    ../../resources/base.resource


Suite Setup    Create Session API


*** Test Cases ***
Eu como novo admin posso cadastrar um filme
    [Tags]    ac-41
    ${name}=    Gerando Nome Aleatório
    ${temp_email}=   Gerando Email Aleatório
    ${temp_password}=    Set Variable    admin123

    ${admin_email}    ${admin_password}=    Register Admin API    ${name}    ${temp_email}    ${temp_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}

    Set Suite Variable    ${admin_email}
    Set Suite Variable    ${admin_password}

    Log    ${token}
    Should Not Be Empty    ${token}    Token do admin foi retornado!
    
    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}=    Gerar Dados Fake de Filme
    ${movie_id}=    Cadastrar Filme API    ${token}    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}
    Should Not Be Empty    ${movie_id}

Eu como admin posso buscar um filme por id
    [Tags]    ac-26
    ${name}=    Gerando Nome Aleatório
    ${temp_email}=   Gerando Email Aleatório
    ${temp_password}=    Set Variable    admin123
    ${admin_email}    ${admin_password}=    Register Admin API    ${name}    ${temp_email}    ${temp_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}
    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}=    Gerar Dados Fake de Filme
    ${movie_id}=    Cadastrar Filme API    ${token}    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}
    ${filme}=    Buscar Filme Por ID API    ${token}    ${movie_id}
    Should Be Equal    ${filme['id']}    ${movie_id}
    Should Be Equal    ${filme['title']}    ${title}

Eu como admin posso atualizar um filme
    [Tags]    ac-15
    ${name}=    Gerando Nome Aleatório
    ${temp_email}=   Gerando Email Aleatório
    ${temp_password}=    Set Variable    admin123
    ${admin_email}    ${admin_password}=    Register Admin API    ${name}    ${temp_email}    ${temp_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}
    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}=    Gerar Dados Fake de Filme
    ${movie_id}=    Cadastrar Filme API    ${token}    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}
    ${novo_title}=    Set Variable    Filme Atualizado
    ${filme_atualizado}=    Atualizar Filme API    ${token}    ${movie_id}    ${novo_title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}
    Should Be Equal    ${filme_atualizado['title']}    ${novo_title}

Eu como admin posso deletar um filme
    [Tags]    ac-44
    ${name}=    Gerando Nome Aleatório
    ${temp_email}=   Gerando Email Aleatório
    ${temp_password}=    Set Variable    admin123
    ${admin_email}    ${admin_password}=    Register Admin API    ${name}    ${temp_email}    ${temp_password}
    ${token}=    Login API    ${admin_email}    ${admin_password}
    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}=    Gerar Dados Fake de Filme
    ${movie_id}=    Cadastrar Filme API    ${token}    ${title}    ${synopsis}    ${director}    ${genres}    ${duration}    ${classification}    ${poster}    ${releaseDate}
    ${success}=    Deletar Filme API    ${token}    ${movie_id}
    Should Be True    ${success}