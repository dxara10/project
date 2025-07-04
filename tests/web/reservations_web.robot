*** Settings ***
Resource    ../../resources/web/reservations_web.resource

Suite Setup    Abrir Navegador

Suite Teardown    Fechar Navegador

*** Test Cases ***
Criar reserva como usuário logado
    Fazer Login Usuario
    Acessar Página de Sessões
    Selecionar Sessão Disponível
    Selecionar Assentos    2
    Confirmar Reserva
    Verificar Mensagem de Sucesso    Reserva realizada com sucesso

Listar reservas do usuário
    Fazer Login Usuario
    Acessar Página de Minhas Reservas
    Verificar Reserva Listada

Cancelar reserva existente
    Fazer Login Usuario
    Acessar Página de Minhas Reservas
    Selecionar Reserva
    Cancelar Reserva
    Verificar Mensagem de Sucesso    Reserva cancelada com sucesso

Admin pode listar todas as reservas
    Fazer Login Admin
    Acessar Página de Reservas Admin
    Verificar Reservas Listadas