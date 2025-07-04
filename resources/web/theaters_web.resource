*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Abrir Navegador
    Open Browser    http://localhost:3002/theaters    chrome
    Maximize Browser Window

Fechar Navegador
    Close Browser

Fazer Login Admin
    Go To    http://localhost:3002/auth/login
    Input Text    id=email    admin@mail.com
    Input Text    id=password    admin123
    Click Button    id=login

Acessar Página de Cadastro de Teatro
    Go To    http://localhost:3002/theaters/register

Preencher Formulário de Cadastro de Teatro
    [Arguments]    ${nome}    ${capacidade}    ${tipo}
    Input Text    id=name    ${nome}
    Input Text    id=capacity    ${capacidade}
    Input Text    id=type    ${tipo}

Submeter Cadastro de Teatro
    Click Button    id=submit

Verificar Mensagem de Sucesso
    [Arguments]    ${mensagem}
    Page Should Contain    ${mensagem}

Acessar Página de Listagem de Teatros
    Go To    http://localhost:3002/theaters

Verificar Teatro na Lista
    [Arguments]    ${nome}
    Page Should Contain    ${nome}

Selecionar Teatro para Edição
    [Arguments]    ${nome}
    Click Link    ${nome}
    Click Button    id=edit

Alterar Nome do Teatro
    [Arguments]    ${novo_nome}
    Input Text    id=name    ${novo_nome}

Salvar Alterações
    Click Button    id=save

Selecionar Teatro para Exclusão
    [Arguments]    ${nome}
    Click Link    ${nome}
    Click Button    id=delete

Confirmar Exclusão
    Click Button    id=confirm