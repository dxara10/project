*** Settings ***
Resource    ../../resources/web/theaters_web.resource

Suite Setup       New Browser    browser=firefox    headless=false
Suite Teardown    Close Browser

*** Test Cases ***
Cadastrar teatro como admin
    Fazer Login Admin
    Acessar Página de Cadastro de Teatro
    Preencher Formulário de Cadastro de Teatro    Teatro Central    100    standard
    Submeter Cadastro de Teatro
    Verificar Mensagem de Sucesso    Teatro cadastrado com sucesso

Listar teatros
    Fazer Login Admin
    Acessar Página de Listagem de Teatros
    Verificar Teatro na Lista    Teatro Central

Editar teatro existente
    Fazer Login Admin
    Acessar Página de Listagem de Teatros
    Selecionar Teatro para Edição    Teatro Central
    Alterar Nome do Teatro    Teatro Atualizado
    Salvar Alterações
    Verificar Mensagem de Sucesso    Teatro atualizado com sucesso

Deletar teatro existente
    Fazer Login Admin
    Acessar Página de Listagem de Teatros
    Selecionar Teatro para Exclusão    Teatro Atualizado
    Confirmar Exclusão
    Verificar Mensagem de Sucesso    Teatro removido com sucesso
