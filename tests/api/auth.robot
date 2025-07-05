*** Settings ***
Resource    ../../resources/base.resource

Suite Setup    Create Session API

*** Test Cases ***
Cadastro E Login De Novo Usuario
    ${name}=    Gerando Nome Aleatório
    ${email}=   Gerando Email Aleatório
    ${password}=    Set Variable    senha123
    ${user_id}=     Cadastrar Usuario API    ${name}    ${email}    ${password}
    ${token}=       Login API    ${email}    ${password}
    Set Suite Variable    ${email}
    Set Suite Variable    ${password}
    Log    ${token}
    Should Not Be Empty    ${token}    Token do usuário foi retornado!

Cadastro E Login De Novo Admin
    ${name}=    Gerando Nome Aleatório
    ${email}=   Gerando Email Aleatório
    ${admin_password}=    Set Variable    admin123
    ${admin_id}=    Register Admin API    ${name}    ${email}    ${admin_password}
    ${token}=       Login API    ${email}    ${admin_password}
    Set Suite Variable    ${admin_email}    ${email}
    Set Suite Variable    ${admin_password}
    Log    ${token}
    Should Not Be Empty    ${token}    Token do admin foi retornado!

Login do Novo Usuario
    ${token}=    Login API    ${email}    ${password}
    Should Not Be Empty    ${token}    Token do usuário foi retornado no login!

Atualizar Senha do Usuario
    ${token}=    Login API    ${email}    ${password}
    Should Not Be Empty    ${token}    Token do usuário foi retornado no login!
    Log    Token do usuário: ${token}

    ${new_password}=    Set Variable    newuser123
    Update Password API    ${email}    ${password}    ${new_password}

    # Login com a nova senha
    ${token}=    Login API    ${email}    ${new_password}
    Should Not Be Empty    ${token}    Token do usuário foi retornado após atualização de senha!






