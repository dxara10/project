*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Abrir Navegador
    Open Browser    http://localhost:30002users    chrome
    Maximize Browser Window

Fechar Navegador
    Close Browser

Acessar Página de Cadastro de Usuário
    Go To    http://localhost:3002/users/register

Preencher Formulário de Cadastro
    [Arguments]    ${nome}    ${email}    ${senha}
    Input Text    id=name    ${nome}
    Input Text    id=email    ${email}
    Input Text    id=password    ${senha}

Submeter Cadastro
    Click Button    id=submit

Verificar Mensagem de Sucesso
    [Arguments]    ${mensagem}
    Page Should Contain    ${mensagem}

Acessar Página de Login
    Go To    http://localhost:3002/auth/login

Preencher Formulário de Login
    [Arguments]    ${email}    ${senha}
    Input Text    id=email    ${email}
    Input Text    id=password    ${senha}

Submeter Login
    Click Button    id=login

Verificar Login Efetuado
    Page Should Contain    Bem-vindo

Fazer Login Admin
    Go To    http://localhost:3002/auth/login
    Input Text    id=email    admin@mail.com
    Input Text    id=password    admin123
    Click Button    id=login

Acessar Página de Listagem de Usuários
    Go To    http://localhost:3002/users

Verificar Usuário na Lista
    [Arguments]    ${nome}
    Page Should Contain    ${nome}

Acessar Página de Edição de Usuário
    [Arguments]    ${nome}
    Click Link    ${nome}
    Click Button    id=edit

Alterar Nome do Usuário
    [Arguments]    ${novo_nome}
    Input Text    id=name    ${novo_nome}

Salvar Alterações
    Click Button    id=save