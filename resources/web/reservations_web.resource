*** Settings ***
Library    Browser

*** Keywords ***
Fazer Login Usuario
    New Page    http://localhost:3002/auth/login
    Fill Text    css=#email    usuario@mail.com
    Fill Text    css=#password    senha123
    Click    css=#login
    Wait For Elements State    text=Bem-vindo    visible

Fazer Login Admin
    New Page    http://localhost:3002/auth/login
    Fill Text    css=#email    admin@mail.com
    Fill Text    css=#password    admin123
    Click    css=#login
    Wait For Elements State    text=Bem-vindo    visible

Acessar Página de Sessões
    Go To    http://localhost:3002/sessions

Selecionar Sessão Disponível
    Click    css=.session-row:first-child .reserve-btn

Selecionar Assentos
    [Arguments]    ${quantidade}
    # Exemplo para rfbrowser: selecionar os primeiros 'quantidade' assentos
    FOR    ${i}    IN RANGE    1    ${quantidade}+1
        Click    xpath=(//input[@type="checkbox"])[${i}]
    END

Confirmar Reserva
    Click    css=#confirm

Verificar Mensagem de Sucesso
    [Arguments]    ${mensagem}
    Wait For Elements State    text=${mensagem}    visible

Acessar Página de Minhas Reservas
    Go To    http://localhost:3002/reservations

Verificar Reserva Listada
    Wait For Elements State    text=Reserva    visible

Selecionar Reserva
    Click    css=.reservation-row:first-child

Cancelar Reserva
    Click    css=#cancel

Acessar Página de Reservas Admin
    Go To    http://localhost:3002/admin/reservations

Verificar Reservas Listadas
    Wait For Elements State    text=Reserva    visible
