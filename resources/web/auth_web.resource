*** Settings ***
Library    Browser

*** Keywords ***
Abrir Navegador
    New Browser    browser=firefox    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}

Fechar Navegador
    Close Browser

Acessar Página de Login
    New Page    http://localhost:3002/auth/login

Preencher Formulário de Login
    [Arguments]    ${email}    ${senha}
    Fill Text    css=#email    ${email}
    Fill Text    css=#password    ${senha}

Submeter Login
    Click    css=#login

Verificar Login Efetuado
    Wait For Elements State    text=Bem-vindo    visible

Verificar Mensagem de Erro
    [Arguments]    ${mensagem}
    Wait For Elements State    text=${mensagem}    visible

Fazer Login Admin
    Acessar Página de Login
    Preencher Formulário de Login    admin@mail.com    admin123
    Submeter Login
    Verificar Login Efetuado

Realizar Logout
    Click    css=#logout

Verificar Página de Login
    Wait For Elements State    text=Login    visible

Clicar em Esqueci Minha Senha
    Click    text=Esqueci minha senha

Preencher Email para Redefinição
    [Arguments]    ${email}
    Fill Text    css=#email    ${email}

Submeter Redefinição
    Click    css=#reset

Verificar Mensagem de Sucesso
    [Arguments]    ${mensagem}
    Wait For Elements State    text=${mensagem}    visible
