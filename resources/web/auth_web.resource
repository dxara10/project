*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Abrir Navegador
    Open Browser    http://localhost:3002/auth/login    chrome
    Maximize Browser Window

Fechar Navegador
    Close Browser

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

Verificar Mensagem de Erro
    [Arguments]    ${mensagem}
    Page Should Contain    ${mensagem}

Fazer Login Admin
    Go To    http://localhost:3002/auth/login
    Input Text    id=email    admin@mail.com
    Input Text    id=password    admin123
    Click Button    id=login

Realizar Logout
    Click Button    id=logout

Verificar Página de Login
    Page Should Contain    Login

Clicar em Esqueci Minha Senha
    Click Link    Esqueci minha senha

Preencher Email para Redefinição
    [Arguments]    ${email}
    Input Text    id=email    ${email}

Submeter Redefinição
    Click Button    id=reset

Verificar Mensagem de Sucesso
    [Arguments]    ${mensagem}
    Page Should Contain    ${mensagem}