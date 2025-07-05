*** Settings ***
Resource    ../../resources/base.resource

Suite Setup       New Browser    browser=firefox    headless=false
Suite Teardown    Close Browser

*** Test Cases ***
Cadastro de usuário com sucesso
    Acessar Página de Cadastro de Usuário
    Preencher Formulário de Cadastro    nome=${TEST_NAME}    email=    senha=senha123
    Submeter Cadastro
    Verificar Mensagem de Sucesso    Usuário cadastrado com sucesso

Login de usuário recém-cadastrado
    Acessar Página de Login
    Preencher Formulário de Login    email=joao${random}@mail.com    senha=senha123
    Submeter Login
    Verificar Login Efetuado

Listar usuários como admin
    Fazer Login Admin
    Acessar Página de Listagem de Usuários
    Verificar Usuário na Lista    João Teste

Editar usuário existente
    Fazer Login Admin
    Acessar Página de Edição de Usuário    João Teste
    Alterar Nome do Usuário    João Editado
    Salvar Alterações
    Verificar Mensagem de Sucesso    Usuário atualizado com sucesso
