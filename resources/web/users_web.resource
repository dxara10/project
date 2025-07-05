*** Settings ***
Library    Browser

*** Keywords ***
Abrir Navegador
    New Browser    headless=false
    New Context

Fechar Navegador
    Close Browser

Acessar Página de Cadastro de Usuário
    New Page    http://localhost:3002/users/register

Preencher Formulário de Cadastro
    [Arguments]    ${nome}    ${email}    ${senha}
    Fill Text    input[name="name"]    ${nome}
    Fill Text    input[name="email"]    ${email}
    Fill Text    input[name="password"]    ${senha}

Submeter Cadastro
    Click    button[type="submit"]

Verificar Mensagem de Sucesso
    [Arguments]    ${mensagem}
    Wait For Elements State    text=${mensagem}    visible    timeout=5s

Acessar Página de Login
    Go To    http://localhost:3002/auth/login

Preencher Formulário de Login
    [Arguments]    ${email}    ${senha}
    Fill Text    input[name="email"]    ${email}
    Fill Text    input[name="password"]    ${senha}

Submeter Login
    Click    button[type="submit"]

Verificar Login Efetuado
    Wait For Elements State    text=Bem-vindo    visible    timeout=5s

Fazer Login Admin
    Go To    http://localhost:3002/auth/login
    Fill Text    input[name="email"]    admin@mail.com
    Fill Text    input[name="password"]    admin123
    Click    button[type="submit"]
    Wait For Elements State    text=Bem-vindo    visible    timeout=5s

Acessar Página de Listagem de Usuários
    Go To    http://localhost:3002/users

Verificar Usuário na Lista
    [Arguments]    ${nome}
    Wait For Elements State    text=${nome}    visible    timeout=5s

Acessar Página de Edição de Usuário
    [Arguments]    ${nome}
    Click    text=${nome}
    Click    css=button#edit

Alterar Nome do Usuário
    [Arguments]    ${novo_nome}
    Fill Text    input[name="name"]    ${novo_nome}

Salvar Alterações
    Click    button#save
