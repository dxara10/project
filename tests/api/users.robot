*** Settings ***
Resource    ../../resources/base.resource


Suite Setup    Create Session API

*** Test Cases ***
Eu posso cadastrar um usuário
    [Tags]    ac-46
    ${name}    ${email}    ${password}=    Gerar Dados Fake de Usuario
    ${user_id}    ${token}=    Cadastrar Usuario API    ${name}    ${email}    ${password}
    Should Not Be Empty    ${user_id}
    Should Not Be Empty    ${token}

Eu posso buscar um usuário por id
    [Tags]    ac-89
    ${name}    ${email}    ${password}=    Gerar Dados Fake de Usuario
    ${user_id}    ${token}=    Cadastrar Usuario API    ${name}    ${email}    ${password}
    ${usuario}=    Buscar Usuario Por ID API    ${token}    ${user_id}
    Should Be Equal    ${usuario['_id']}    ${user_id}

Eu posso atualizar um usuário
    [Tags]    ac-90
    ${name}    ${email}    ${password}=    Gerar Dados Fake de Usuario
    ${user_id}    ${token}=    Cadastrar Usuario API    ${name}    ${email}    ${password}
    ${novo_nome}=    Set Variable    Usuario Atualizado
    ${usuario_atualizado}=    Atualizar Usuario API    ${token}    ${user_id}    ${novo_nome}    ${email}
    Should Be Equal    ${usuario_atualizado['name']}    ${novo_nome}

Eu posso deletar um usuário
    [Tags]    ac-91
    ${name}    ${email}    ${password}=    Gerar Dados Fake de Usuario
    ${user_id}    ${token}=    Cadastrar Usuario API    ${name}    ${email}    ${password}
    ${success}=    Deletar Usuario API    ${token}    ${user_id}
    Should Be True    ${success}