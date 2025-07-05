*** Settings ***
Library    Browser

*** Keywords ***
Fazer Login Admin
    New Page    http://localhost:3002/auth/login
    Fill Text    css=#email    admin@mail.com
    Fill Text    css=#password    admin123
    Click    css=#login
    Wait For Elements State    text=Bem-vindo    visible

Acessar Página de Cadastro de Teatro
    Go To    http://localhost:3002/theaters/register

Preencher Formulário de Cadastro de Teatro
    [Arguments]    ${nome}    ${capacidade}    ${tipo}
    Fill Text    css=#name    ${nome}
    Fill Text    css=#capacity    ${capacidade}
    Fill Text    css=#type    ${tipo}

Submeter Cadastro de Teatro
    Click    css=#submit

Verificar Mensagem de Sucesso
    [Arguments]    ${mensagem}
    Wait For Elements State    text=${mensagem}    visible

Acessar Página de Listagem de Teatros
    Go To    http://localhost:3002/theaters

Verificar Teatro na Lista
    [Arguments]    ${nome}
    Wait For Elements State    text=${nome}    visible

Selecionar Teatro para Edição
    [Arguments]    ${nome}
    Click    text=${nome}
    Click    css=#edit

Alterar Nome do Teatro
    [Arguments]    ${novo_nome}
    Fill Text    css=#name    ${novo_nome}

Salvar Alterações
    Click    css=#save

Selecionar Teatro para Exclusão
    [Arguments]    ${nome}
    Click    text=${nome}
    Click    css=#delete

Confirmar Exclusão
    Click    css=#confirm
