*** Settings ***
Documentation    Page Object – tela de Teatros: navegação e operações de teatro.
Library          Browser
Resource         ../../base.resource

*** Keywords ***
Fazer Login Admin Teatro
    Go To    http://localhost:3002/login
    Fill Text    input[name="email"]       ${ADMIN_EMAIL}
    Fill Text    input[name="password"]    ${ADMIN_PASSWORD}
    Click    button[type="submit"]
    Wait For Elements State    text=Bem-vindo    visible    timeout=10s

Acessar Página de Cadastro de Teatro
    Go To    http://localhost:3002/theaters/register
    Wait For Elements State    input[name="name"]    visible    timeout=10s

Preencher Formulário de Cadastro de Teatro
    [Arguments]    ${nome}    ${capacidade}    ${tipo}
    Fill Text    input[name="name"]        ${nome}
    Fill Text    input[name="capacity"]    ${capacidade}
    Fill Text    input[name="type"]        ${tipo}

Submeter Cadastro de Teatro
    Click    button[type="submit"]

Verificar Mensagem de Sucesso Teatro
    [Arguments]    ${mensagem}
    Wait For Elements State    text=${mensagem}    visible    timeout=5s

Acessar Página de Listagem de Teatros
    Go To    http://localhost:3002/theaters
    Wait For Elements State    css=.theater-row    visible    timeout=10s

Verificar Teatro na Lista
    [Arguments]    ${nome}
    Wait For Elements State    text=${nome}    visible    timeout=5s

Selecionar Teatro para Edição
    [Arguments]    ${nome}
    Click    text=${nome}
    Click    css=button[data-action="edit"]

Alterar Nome do Teatro
    [Arguments]    ${novo_nome}
    Fill Text    input[name="name"]    ${novo_nome}

Salvar Alterações Teatro
    Click    css=button[data-action="save"]

Selecionar Teatro para Exclusão
    [Arguments]    ${nome}
    Click    text=${nome}
    Click    css=button[data-action="delete"]

Confirmar Exclusão Teatro
    Click    css=button[data-action="confirm"]