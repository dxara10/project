*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Abrir Navegador
    Open Browser    http://localhost:3002    chrome
    Maximize Browser Window

Fechar Navegador
    Close Browser

Fazer Login Usuario
    Go To    http://localhost:3002/auth/login
    Input Text    id=email    usuario@mail.com
    Input Text    id=password    senha123
    Click Button    id=login

Fazer Login Admin
    Go To    http://localhost:3002/auth/login
    Input Text    id=email    admin@mail.com
    Input Text    id=password    admin123
    Click Button    id=login

Acessar Página de Sessões
    Go To    http://localhost:3002/sessions

Selecionar Sessão Disponível
    Click Element    css=.session-row:first-child .reserve-btn

Selecionar Assentos
    [Arguments]    ${quantidade}
    # Exemplo: selecionar os dois primeiros assentos disponíveis
    Click Element    xpath=(//input[@type="checkbox"])[1]
    Click Element    xpath=(//input[@type="checkbox"])[2]

Confirmar Reserva
    Click Button    id=confirm

Verificar Mensagem de Sucesso
    [Arguments]    ${mensagem}
    Page Should Contain    ${mensagem}

Acessar Página de Minhas Reservas
    Go To    http://localhost:3002/reservations

Verificar Reserva Listada
    Page Should Contain    Reserva

Selecionar Reserva
    Click Element    css=.reservation-row:first-child

Cancelar Reserva
    Click Button    id=cancel

Acessar Página de Reservas Admin
    Go To    http://localhost:3002/admin/reservations

Verificar Reservas Listadas
    Page Should Contain    Reserva