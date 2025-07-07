*** Settings ***
Documentation    Page Object – tela de Usuários: navegação e operações de usuário.
Library          Browser
Resource         ../../base.resource

*** Keywords ***
Acessar Página de Cadastro de Usuário
    Go To    http://localhost:3002/users/register
    Wait For Elements State    input[name="name"]    visible    timeout=10s

Preencher Formulário de Cadastro Usuario
    [Arguments]    ${nome}    ${email}    ${senha}
    Fill Text    input[name="name"]       ${nome}
    Fill Text    input[name="email"]      ${email}
    Fill Text    input[name="password"]   ${senha}

Submeter Cadastro Usuario
    Click    button[type="submit"]

Verificar Mensagem de Sucesso Usuario
    [Arguments]    ${mensagem}
    Wait For Elements State    text=${mensagem}    visible    timeout=5s

Acessar Página de Login Usuario
    Go To    http://localhost:3002/login
    Wait For Elements State    input[name="email"]    visible    timeout=10s

Preencher Formulário de Login Usuario
    [Arguments]    ${email}    ${senha}
    Fill Text    input[name="email"]       ${email}
    Fill Text    input[name="password"]    ${senha}

Submeter Login Usuario
    Click    button[type="submit"]

Verificar Login Efetuado Usuario
    Wait For Elements State    text=Bem-vindo    visible    timeout=10s

Fazer Login Admin Usuario
    Go To    http://localhost:3002/login
    Fill Text    input[name="email"]       ${ADMIN_EMAIL}
    Fill Text    input[name="password"]    ${ADMIN_PASSWORD}
    Click    button[type="submit"]
    Wait For Elements State    text=Bem-vindo    visible    timeout=10s

Acessar Página de Listagem de Usuários
    Go To    http://localhost:3002/users
    Wait For Elements State    css=.user-row    visible    timeout=10s

Verificar Usuário na Lista
    [Arguments]    ${nome}
    Wait For Elements State    text=${nome}    visible    timeout=5s

Acessar Página de Edição de Usuário
    [Arguments]    ${nome}
    Click    text=${nome}
    Click    css=button[data-action="edit"]

Alterar Nome do Usuário
    [Arguments]    ${novo_nome}
    Fill Text    input[name="name"]    ${novo_nome}

Salvar Alterações Usuario
    Click    css=button[data-action="save"]