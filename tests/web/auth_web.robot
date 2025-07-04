*** Settings ***
Resource    ../../resources/web/auth_web.resource

Suite Setup    Abrir Navegador

Suite Teardown    Fechar Navegador

*** Test Cases ***
Login com credenciais válidas
    Acessar Página de Login
    Preencher Formulário de Login    admin@mail.com    admin123
    Submeter Login
    Verificar Login Efetuado

Login com credenciais inválidas
    Acessar Página de Login
    Preencher Formulário de Login    fake@mail.com    senhaerrada
    Submeter Login
    Verificar Mensagem de Erro    Credenciais inválidas

Logout do sistema
    Fazer Login Admin
    Realizar Logout
    Verificar Página de Login

Redefinir senha
    Acessar Página de Login
    Clicar em Esqueci Minha Senha
    Preencher Email para Redefinição    admin@mail.com
    Submeter Redefinição
    Verificar Mensagem de Sucesso    Email de redefinição enviado